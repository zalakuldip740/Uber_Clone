import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:uber_driver_app/core/internet/internet_cubit.dart';
import 'package:uber_driver_app/core/widgets/loading_widget.dart';
import 'package:uber_driver_app/core/widgets/no_internet_widget.dart';
import 'package:uber_driver_app/features/uber_profile_feature/presentation/pages/uber_profile_page.dart';
import 'package:uber_driver_app/features/uber_trip_feature/presentation/cubit/driver_live_location/driver_location_cubit.dart';
import 'package:uber_driver_app/features/uber_trip_feature/presentation/cubit/uber_driver_map/uber_map_cubit.dart';
import 'package:uber_driver_app/features/uber_trip_feature/presentation/widgets/functional_button.dart';
import 'package:uber_driver_app/features/uber_trip_feature/presentation/widgets/google_map_widget.dart';
import 'package:uber_driver_app/features/uber_trip_feature/presentation/widgets/is_online_widget.dart';
import 'package:uber_driver_app/features/uber_trip_feature/presentation/widgets/profile_widget.dart';
import 'package:uber_driver_app/features/uber_trip_feature/presentation/widgets/ride_req_bottomsheet_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    Geolocator.requestPermission();
    try {
      BlocProvider.of<InternetCubit>(context).monitorInternetConnection();
      BlocProvider.of<DriverLocationCubit>(context).getDriverLocation();
    } on Exception catch (e) {
      print(e);
    }
  }

  @override
  void dispose() {
    super.dispose();
    try {
      BlocProvider.of<DriverLocationCubit>(context).cancelTimer();
      BlocProvider.of<InternetCubit>(context).close();
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<InternetCubit, InternetState>(
      builder: (context, state) {
        if (state is InternetLoading) {
          return const LoadingWidget();
        }
        if (state is InternetConnected) {
          return Scaffold(
            bottomNavigationBar:
                BlocBuilder<DriverLocationCubit, DriverLocationState>(
              builder: (context, state) {
                if (state is DriverLocationInitial ||
                    state is DriverLocationLoading) {
                  BlocProvider.of<DriverLocationCubit>(context)
                      .getDriverLocation();
                }
                if (state is DriverLocationLoaded) {
                  BlocProvider.of<DriverLocationCubit>(context).is_online =
                      state.driverModel.is_online!;
                  if (state.driverModel.is_online == true) {
                    BlocProvider.of<DriverLocationCubit>(context)
                        .startTimer(state.driverModel);
                  } else {
                    BlocProvider.of<DriverLocationCubit>(context).cancelTimer();
                  }
                  return Container(
                    height: 90,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                            color: Colors.grey,
                            blurRadius: 11,
                            offset: Offset(3.0, 4.0))
                      ],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        InkWell(
                          onTap: () {
                            rideRequestBottomSheet(context);
                          },
                          child: Container(
                            padding: const EdgeInsets.only(left: 20),
                            child: const Icon(Icons.keyboard_arrow_up),
                          ),
                        ),
                        Text(
                            state.driverModel.is_online == true
                                ? "You're online"
                                : "You're offline",
                            style: const TextStyle(
                                fontSize: 30, color: Colors.blueAccent)),
                        Container(
                            padding: const EdgeInsets.only(right: 20),
                            child: const Icon(Icons.list)),
                      ],
                    ),
                  );
                }
                return const SizedBox.shrink();
              },
            ),
            resizeToAvoidBottomInset: false,
            body: Stack(
              children: [
                BlocBuilder<UberMapCubit, UberMapState>(
                    builder: (context, state) {
                  if (state is UberMapInitial) {
                    return GoogleMapWidget(const {}, const {});
                  } else if (state is UberMapLoading) {
                    return const Center(
                      child: CircularProgressIndicator(
                        strokeWidth: 5,
                        color: Colors.black45,
                      ),
                    );
                  } else if (state is UberMapLoaded) {
                    return GoogleMapWidget(
                      state.markers,
                      state.polylines,
                    );
                  }
                  return GoogleMapWidget(const {}, const {});
                }),
                Positioned(
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: Container(
                      margin: const EdgeInsets.only(top: 30),
                      child:
                          BlocBuilder<DriverLocationCubit, DriverLocationState>(
                        builder: (context, state) {
                          if (state is DriverLocationInitial ||
                              state is DriverLocationLoading) {
                            BlocProvider.of<DriverLocationCubit>(context)
                                .getDriverLocation();
                          }
                          if (state is DriverLocationLoaded) {
                            return Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                FunctionalButton(
                                  icon: Icons.search,
                                  title: "",
                                  onPressed: () {},
                                ),
                                IsOnlineWidget(
                                  online: state.driverModel.is_online == true
                                      ? "Online"
                                      : "Offline",
                                  onPressed: () {
                                    if (state.driverModel.is_online != null) {
                                      BlocProvider.of<DriverLocationCubit>(
                                              context)
                                          .updateDriver(
                                              !state.driverModel.is_online!,
                                              state.driverModel);
                                    }
                                  },
                                ),
                                ProfileWidget(
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const UberProfilePage()));
                                  },
                                  imgUrl:
                                      state.driverModel.profile_img.toString(),
                                ),
                              ],
                            );
                          }
                          return const CircularProgressIndicator();
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        } else if (state is InternetDisconnected) {
          return const NoInternetWidget(
            message: 'Check Your Internet Connection.',
          );
        }

        return const NoInternetWidget(
            message: "Something went wrong!!Please restart the app.");
      },
    );
  }
}
