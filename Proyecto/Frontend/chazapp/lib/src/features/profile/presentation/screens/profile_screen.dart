import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'package:chazapp/injection_container.dart';
import 'package:chazapp/src/config/themes/unchaza_theme.dart';
import 'package:chazapp/src/features/home/presentation/widgets/custom_app_bar.dart';
import 'package:chazapp/src/features/home/presentation/widgets/custom_button.dart';
import 'package:chazapp/src/features/auth/presentation/bloc/login/login_bloc.dart';
import 'package:chazapp/src/features/auth/presentation/bloc/login/login_event.dart';
import 'package:chazapp/src/features/auth/presentation/bloc/login/login_state.dart';
import 'package:chazapp/src/features/profile/presentation/bloc/profile/profile_bloc.dart';
import 'package:chazapp/src/features/profile/presentation/bloc/profile/profile_event.dart';
import 'package:chazapp/src/features/profile/presentation/bloc/profile/profile_state.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<LoginBloc, LoginState>(
        listener: (context, state) {
          if (state is LoginFailure || state is NoToken) {
            context.go("/login");
            return;
          }
          if (state is! LoginSuccess) {
            context.read<LoginBloc>().add(CheckAuthStatus());
          }
        },
        child: BlocBuilder<LoginBloc, LoginState>(
          builder: (context, state) {
            if (state is LoginFailure || state is NoToken) {
              context.go("/");
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            if (state is! LoginSuccess) {
              context.read<LoginBloc>().add(CheckAuthStatus());
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            final token = (state).userEntity.token;

            return BlocProvider(
              create: (context) =>
                  sl<ProfileBloc>()..add(ProfileRequested(token)),
              child: BlocBuilder<ProfileBloc, ProfileState>(
                builder: (context, state) {
                  if (state is ProfileLoading) {
                    return const Center(
                      heightFactor: 20,
                      child:
                          CircularProgressIndicator(color: UNChazaTheme.orange),
                    );
                  } else if (state is ProfileSuccess) {
                    return Scaffold(
                      appBar: const CustomAppBar(type: AppBarType.profile),
                      body: SingleChildScrollView(
                        child: ConstrainedBox(
                          constraints: BoxConstraints(
                            minHeight: MediaQuery.of(context).size.height,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Align(
                                  alignment: Alignment.center,
                                  child: Text('Mi perfil',
                                      style: UNChazaTheme.textTheme.displayLarge
                                          ?.copyWith(
                                              color: UNChazaTheme.orange)),
                                ),
                                const SizedBox(height: 20),
                                Row(
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(80),
                                      child: Image.network(
                                        'https://images.crunchbase.com/image/upload/c_thumb,h_256,w_256,f_auto,g_face,z_0.7,q_auto:eco,dpr_1/xh3bkyq1g1yx5rasenzt',
                                        width: 140,
                                        height: 140,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    const SizedBox(width: 10),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text('Juliana Paez',
                                            style: UNChazaTheme
                                                .textTheme.displayMedium),
                                        Text(state.profileEntity.email,
                                            style: UNChazaTheme
                                                .textTheme.bodyLarge),
                                        const SizedBox(height: 5),
                                        CustomButton(
                                          text: "Editar",
                                          buttonColor: UNChazaTheme.orange,
                                          textColor: UNChazaTheme.mainGrey,
                                          onPressed: () {},
                                        )
                                      ],
                                    )
                                  ],
                                ),
                                const SizedBox(height: 10),
                                Text("Mis chazas",
                                    style: UNChazaTheme.textTheme.displayMedium,
                                    textAlign: TextAlign.start),
                                const Divider(
                                  height: 4,
                                  color: UNChazaTheme.lightGrey,
                                  thickness: 2,
                                ),
                                const SizedBox(height: 10),
                                CustomButton(
                                  text: "Crear chaza",
                                  buttonColor: UNChazaTheme.orange,
                                  textColor: UNChazaTheme.white,
                                  onPressed: () {
                                    context.go("/createchaza");
                                  },
                                  icon: Icons.add_circle_outline_rounded,
                                ),
                                state.chazas.isNotEmpty
                                    ? SizedBox(
                                        height: 200,
                                        child: ListView.builder(
                                          shrinkWrap: true,
                                          // physics:
                                          //     const NeverScrollableScrollPhysics(),
                                          itemCount: state.chazas.length,
                                          itemBuilder: (context, index) {
                                            final chaza = state.chazas[index];
                                            return GestureDetector(
                                              onTap: () {
                                                context.push('/chaza-detail2',
                                                    extra: {
                                                      'imageUrl':
                                                          "https://images.crunchbase.com/image/upload/c_thumb,h_256,w_256,f_auto,g_face,z_0.7,q_auto:eco,dpr_1/xh3bkyq1g1yx5rasenzt",
                                                      'chaza': chaza,
                                                      'isOwner': true,
                                                      'schedule':
                                                          "Lunes a viernes de 8:00 a.m. a 5:00 p.m.",
                                                      'payment':
                                                          "Efectivo, tarjeta",
                                                    });
                                              },
                                              child: ListTile(
                                                title: Text(chaza.nombre),
                                                subtitle:
                                                    Text(chaza.descripcion),
                                              ),
                                            );
                                          },
                                        ),
                                      )
                                    : const Text('No tienes chazas'),
                                // Text("Mis favoritos",
                                //     style: UNChazaTheme.textTheme.displayMedium,
                                //     textAlign: TextAlign.start),
                                // const Divider(
                                //   height: 4,
                                //   color: UNChazaTheme.lightGrey,
                                //   thickness: 2,
                                // ),
                                // const SizedBox(height: 10),
                                Align(
                                  alignment: Alignment.center,
                                  child: CustomButton(
                                    text: "Cerrar sesión",
                                    buttonColor: UNChazaTheme.red,
                                    textColor: UNChazaTheme.white,
                                    onPressed: () {
                                      context.go("/");
                                      context
                                          .read<LoginBloc>()
                                          .add(LogoutRequested());
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  } else if (state is ProfileFailure) {
                    return const Center(
                      child: Text('Error al cargar el perfil'),
                    );
                  }

                  return Center(
                    child: Text(state.toString()),
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
