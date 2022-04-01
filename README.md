# Leitura de Cocho


Leitura de Cocho é um aplicativo Flutter desenvolvido para realizar as tarefas do manejo de cocho bovino, visando uma praticidade e facilidade nessa tarefa.

O aplicativo foi desenvolvido para uso dos acadêmicos do Instituto Federal de Ciência e Tecnologia do Norte de Minas Gerais - Campus Salinas que realizam todo o processo do manejo de forma manual.

O aplicativo contém as seguintes funcionalidades:

- Autenticação de login
- Cadastro de usuários
- Cadastro de fazendas
- Cálculo do abastecimento de nutrientes
- Cálculo do absstecimento de mineral
- Histórico de abastecimentos
- Consulta de abastecimentos  tanto po trtador como por identicador do gado
- Visualização de consumo e sobras em formato de gráfico de linhas
- Geração de PDF
- Compartilhamento de registros entre usuarios da mesma fazenda
- Funcionalidade online e offline

Além dessas funcionalidades o aplicativo armazena os dados localmente e em servidorvia API.

## Instalação

Para instalação primeiramente clone o repositório local, em seguida abra o diretório salvo e instale as dependências

```sh
git clone https://github.com/RToramaru/flutter-app
cd flutter-app
flutter pub get
```

## Uso

Para utilizar o aplicativo é necessário adicionar um arquivo assinado key.properties na pasta android.

Após assinado caso desaja salvar os dados em um servidor é necessário adicionar os acesso as API nos arquivos helpers, se encontrando na pasta lib/helpers/ 

Os modelos da API podem ser encontrados no link https://github.com/RToramaru/api-app


## Desenvolvedores
Luana Ataide Castro https://github.com/luanaacastro

Rafael Almeida Soares https://github.com/RToramaru
