import 'package:flutter/material.dart';

void main() {
  runApp(TicTacToeApp());
}

class TicTacToeApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tic Tac Toe',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: TicTacToeHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class TicTacToeHomePage extends StatefulWidget {
  @override
  _TicTacToeHomePageState createState() => _TicTacToeHomePageState();
}

class _TicTacToeHomePageState extends State<TicTacToeHomePage> {
  List<String> board = List.filled(9, '');
  String currentPlayer = 'X';
  String message = 'Turno de X';
  bool gameOver = false;

  void resetGame() {
    setState(() {
      board = List.filled(9, '');
      currentPlayer = 'X';
      message = 'Turno de X';
      gameOver = false;
    });
  }

  void playMove(int index) {
    if (board[index] == '' && !gameOver) {
      setState(() {
        board[index] = currentPlayer;
        if (checkWinner(currentPlayer)) {
          message = 'Jogador $currentPlayer venceu!';
          gameOver = true;
        } else if (!board.contains('')) {
          message = 'Empate!';
          gameOver = true;
        } else {
          currentPlayer = currentPlayer == 'X' ? 'O' : 'X';
          message = 'Turno de $currentPlayer';
        }
      });
    }
  }

  bool checkWinner(String player) {
    List<List<int>> winningCombos = [
      [0, 1, 2],
      [3, 4, 5],
      [6, 7, 8], // horizontal
      [0, 3, 6],
      [1, 4, 7],
      [2, 5, 8], // vertical
      [0, 4, 8],
      [2, 4, 6]  // diagonal
    ];

    for (var combo in winningCombos) {
      if (board[combo[0]] == player &&
          board[combo[1]] == player &&
          board[combo[2]] == player) {
        return true;
      }
    }
    return false;
  }

  Widget buildCell(int index) {
    return GestureDetector(
      onTap: () => playMove(index),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black),
          color: board[index] == ''
              ? Colors.white
              : board[index] == 'X'
                  ? Colors.lightBlue.shade100
                  : Colors.orange.shade100,
        ),
        child: Center(
          child: Text(
            board[index],
            style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double cellSize = MediaQuery.of(context).size.width / 3 - 16;

    return Scaffold(
      appBar: AppBar(title: Text('Tic Tac Toe')),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(children: [
          Text(
            message,
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
          ),
          SizedBox(height: 20),
          Container(
            height: cellSize * 3,
            child: GridView.builder(
              itemCount: 9,
              gridDelegate:
                  SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
              itemBuilder: (context, index) => buildCell(index),
            ),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: resetGame,
            child: Text('Reiniciar Jogo'),
            style: ElevatedButton.styleFrom(
              padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              textStyle: TextStyle(fontSize: 18),
            ),
          ),
        ]),
      ),
    );
  }
}
