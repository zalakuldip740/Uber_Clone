import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
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
  static const CameraPosition _initialLocation = CameraPosition(
    target: LatLng(23.35125, 72.956),
    zoom: 17.0,
  );

  @override
  void initState() {
    super.initState();
    Geolocator.requestPermission();
    try {
      BlocProvider.of<InternetCubit>(context).monitorInternetConnection();
      BlocProvider.of<DriverLocationCubit>(context).getCurrentLocation(context);
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
                // return const Center(
                //   // child: ElevatedButton(
                //   //   onPressed: (){
                //   //     BlocProvider.of<DriverLocationCubit>(context).getCurrentLocation(context);
                //   //     BlocProvider.of<DriverLocationCubit>(context).getDriverLocation();
                //   //   },
                //   child: Text(""),
                //   // ),
                // );
              },
            ),
            resizeToAvoidBottomInset: false,
            bottomSheet: Container(
              height: 300,
              decoration: const BoxDecoration(color: Colors.black),
              child: Column(),
            ),
            body: Stack(
              children: <Widget>[
                BlocBuilder<UberMapCubit, UberMapState>(
                    builder: (context, state) {
                  if (state is UberMapInitial) {
                    return const UberMapInitialWidget();
                  } else if (state is UberMapLoading) {
                    return const Center(
                      child: CircularProgressIndicator(
                        strokeWidth: 5,
                        color: Colors.black45,
                      ),
                    );
                  } else if (state is UberMapLoaded) {
                    return GoogleMapWidget(state.markers, state.polylines);
                  }

                  return const UberMapInitialWidget();
                }),
                Positioned(
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: Container(
                      margin: const EdgeInsets.only(top: 30),
                      child:
                          BlocBuilder<DriverLocationCubit, DriverLocationState>(
                        builder: (context, state) {
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
                                    } else {}
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
                Positioned(
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 20),
                    child: Align(
                      alignment: Alignment.bottomRight,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          FunctionalButton(
                            icon: Icons.my_location,
                            title: "",
                            onPressed: () {
                              //for animate camera before a ride
                              BlocProvider.of<DriverLocationCubit>(context)
                                  .getCurrentLocation(context);

                              //after drawing route animate camera
                              BlocProvider.of<UberMapCubit>(context)
                                  .getCurrentLocation(context);
                            },
                          ),
                          const SizedBox(
                            width: 50,
                            height: 50,
                          )
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          );
        } else if (state is InternetDisconnected) {
          return const NoInternetWidget(
            message: 'Check Your Internet Connection.',
          );
        }

        return Center(
          child: ElevatedButton(
            onPressed: () {
              BlocProvider.of<InternetCubit>(context)
                  .monitorInternetConnection();
              BlocProvider.of<DriverLocationCubit>(context)
                  .getCurrentLocation(context);
              BlocProvider.of<DriverLocationCubit>(context).getDriverLocation();
            },
            child: const Text("Retry"),
          ),
        );
      },
    );
  }
}

class UberMapInitialWidget extends StatefulWidget {
  const UberMapInitialWidget({Key? key}) : super(key: key);

  @override
  _UberMapInitialWidgetState createState() => _UberMapInitialWidgetState();
}

class _UberMapInitialWidgetState extends State<UberMapInitialWidget> {
  @override
  Widget build(BuildContext context) {
    const CameraPosition _initialLocation = CameraPosition(
      target: LatLng(23.35125, 72.956),
      zoom: 17.0,
    );

    return GoogleMap(
      initialCameraPosition: _initialLocation,
      tiltGesturesEnabled: true,
      compassEnabled: false,
      myLocationButtonEnabled: false,
      onMapCreated: (controller) =>
          BlocProvider.of<DriverLocationCubit>(context)
              .mapController
              .complete(controller),
      myLocationEnabled: true,
      mapType: MapType.normal,
      zoomGesturesEnabled: true,
      zoomControlsEnabled: false,
      markers: {},
      polylines: {},
    );
  }
}
