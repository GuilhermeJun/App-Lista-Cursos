
import 'package:dio/dio.dart';
import 'package:lista_cursos/models/curso_model.dart';
import 'package:lista_cursos/services/Service_config.dart';

class CursoService {
  static final String _endpoint =
      "https://6168464fba841a001727c6b9.mockapi.io/fiap/";

  static final String _resource = 'curso';

  final ServiceConfig service = new ServiceConfig(_endpoint);

  Future<List<CursoModel>> findAll() async {
    List<CursoModel> lista = [];

    try {
      Response response = await service.create().get(_resource);

      if (response.statusCode == 200) {
        response.data.forEach(
          (value) {
            print(value);
            lista.add(
              CursoModel.fromMap(value),      
            );
          },
        );
      }
    } catch (error) {
      print("Service Error: $error ");
      throw error;
    }

    return lista;
  }

  Future<int> create(CursoModel cursoModel) async {
    try {
      cursoModel.id = 0;
      Response response = await service.create().post(
            _resource,
            data: cursoModel.toMap(),
          );

      if (response.statusCode == 201) {
        cursoModel = CursoModel.fromMap(response.data);
        
        var retorno = (response.data["id"] is String)
            ? int.parse(response.data["id"])
            : response.data["id"];
        return retorno;
        
      }
      return cursoModel.id;
    } catch (error) {
      print("Service Error: $error ");
      throw error;
    }
  }

  Future<CursoModel> getById(int id) async {
    try {
      String endpoint = _resource + "/" + id.toString();
      Response response = await service.create().get(endpoint);

      if (response.statusCode == 200) {
        var retorno = CursoModel.fromMap(response.data);
        return retorno;
      }
    } catch (error) {
      print("Service Error: $error ");
      throw error;
    }
  }

  Future<int> update(CursoModel cursoModel) async {
    try {
      String endpoint = _resource + "/" + cursoModel.id.toString();

      Response response = await service.create().put(
            endpoint,
            data: cursoModel.toMap(),
          );

      var retorno = (response.data["id"] is String)
          ? int.parse(response.data["id"])
          : response.data["id"];
      return retorno;
    } catch (error) {
      print("Service Error: $error ");
      throw error;
    }
  }

  Future<void> delete(CursoModel cursoModel) async {
    try {
      String endpoint = _resource + "/" + cursoModel.id.toString();

      Response response = await service.create().delete(
            endpoint,
          );

      if (response.statusCode != 200) {
        throw Exception("N??o foi poss??vel excluir o recurso!");
      }
    } catch (error) {
      throw error;
    }
  }
}
