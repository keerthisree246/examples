import 'package:example/data/data_cubit.dart';
import 'package:example/data/data_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DataScreen extends StatefulWidget {
  const DataScreen({super.key});

  @override
  State<DataScreen> createState() => _DataScreenState();
}

class _DataScreenState extends State<DataScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Data Users'),),
      body: BlocBuilder<DataCubit, DataState>(
        builder: (context,state){
          if(state is DataLoading){
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        else if(state is DataError){
          return Center(
            child: Column(
              children: [
                Text(state.message),
                TextButton(onPressed: ()=> context.read<DataCubit>().dataUsers(), child: Text('retry'))

              ],
            ),
          );

        }
        else if (state is DataSuccess) {
          return Column(
            children: [
              Expanded(child: ListView.builder(
                itemCount: state.success.length,
                itemBuilder: (context,index){
                  final user = state.success[index];
                  return Card(
                    child: ListTile(
                      title: Text(user['name']),
                      subtitle: Text(user['email']),
                      
                    ),
                  );

                }
                ))
            ],
          );
        }
        return const SizedBox.shrink();
        }
        ),

    );
  }
}