import 'package:flutter/material.dart';
import 'package:lista_cursos/models/curso_model.dart';
import 'package:lista_cursos/services/curso_service.dart';

class CursosEditarScreen extends StatefulWidget {
  @override
  _CursosEditarScreenState createState() => _CursosEditarScreenState();
}

class _CursosEditarScreenState extends State<CursosEditarScreen> {
  final GlobalKey<FormState> formKey = new GlobalKey<FormState>();
  CursoModel cursoModel;

  Widget build(BuildContext context) {
    cursoModel = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(64, 75, 96, .9),
        title: Text("Editar Curso"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Center(
              child: Column(
                children: <Widget>[
                  TextFormField(
                    initialValue: cursoModel.nome,
                    decoration: new InputDecoration(
                      icon: const Icon(Icons.text_fields),
                      hintText: 'Digite o nome do curso',
                      labelText: 'Nome',
                    ),
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Digite o nome do curso';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      cursoModel.nome = value;
                    },
                  ),
                  TextFormField(
                    initialValue: cursoModel.preco.toString(),
                    decoration: new InputDecoration(
                      icon: const Icon(Icons.monetization_on),
                      hintText: '999',
                      labelText: 'Preço',
                    ),
                    validator: (value) {
                      if ((value.isEmpty) || (int.parse(value) <= 0)) {
                        return 'Digite um preço válido!';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      cursoModel.preco = int.parse(value);
                    },
                    keyboardType: TextInputType.number,
                  ),
                  TextFormField(
                    initialValue: cursoModel.percentualConclusao.toString(),
                    decoration: new InputDecoration(
                      icon: const Icon(Icons.flight_takeoff),
                      hintText: '99.99',
                      labelText: 'Percentual de conclusão',
                    ),
                    validator: (value) {
                      if ((value.isEmpty) || (double.parse(value) <= 0)) {
                        return 'Digite um percentual correto!';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      var percent = double.parse(value);
                      cursoModel.percentualConclusao = percent;
                    },
                    keyboardType: TextInputType.number,
                  ),
                  TextFormField(
                    initialValue: cursoModel.conteudo,
                    maxLines: 5,
                    decoration: new InputDecoration(
                      alignLabelWithHint: true,
                      icon: const Icon(Icons.description),
                      hintText: 'Conteúdo para o curso',
                      labelText: 'Conteúdo',
                    ),
                    validator: (value) {
                      if ((value.isEmpty)) {
                        return 'Digite o conteúdo do curso!';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      cursoModel.conteudo = value;
                    },
                    keyboardType: TextInputType.multiline,
                  ),
                  DropdownButtonFormField<String>(
                    value: cursoModel.nivel,
                    items:
                        ["Básico", "Intermediário", "Avançado", "Especializado"]
                            .map(
                              (label) => DropdownMenuItem(
                                child: Text(label),
                                value: label,
                              ),
                            )
                            .toList(),
                    decoration: new InputDecoration(
                      alignLabelWithHint: true,
                      icon: const Icon(Icons.score),
                      hintText: 'Selecione o nível',
                      labelText: 'Nível',
                    ),
                    validator: (value) {
                      if ((value == null)) {
                        return 'Selecione o nível do curso!';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      cursoModel.nivel = value;
                    },
                    onChanged: (value) {
                      cursoModel.nivel = value;
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Color.fromRGBO(64, 75, 96, .9), // background
                        onPrimary: Colors.white, // foreground
                      ),
                      child: Text("Gravar"),
                      onPressed: () async {
                        if (formKey.currentState.validate()) {
                          formKey.currentState.save();

                          await CursoService().update(cursoModel);

                          Navigator.pop(
                            context,
                            cursoModel,
                          );
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
