int[][] board;
int winner = 0, shifts = 0, num_Start = (int)(Math.random()*2), chckWin;
int player = 1, x, y, cont, cont2 = 0;
int IA = -1, aux = 0, aux2 = 0, board_Choose = (int)(Math.random()*4), num1, num2; //<>//
PFont f;
String msg;

// Se inicializa el programa y el tablero que inicializa con todos los numeros en 0
void setup(){
  size(600,600);
  f = createFont("AkaashNormal", 16, true);
  board = new int[3][3];
  for(int i = 0; i < 3; i++){
    for(int j = 0; j < 3; j++){
      board[i][j] = 0;
    }
  }
}

// Se dibuja graficamente el tablero
void drawBoard(){
  strokeWeight(7);
  for(int i = 1; i < 3; i++){
    line(10, i*200, 590, i*200);
    line(i*200, 10, i*200, 590);
  }
}

// Se dibuja graficamente la X
void drawX(int x, int y){
  line(x*200+20, y*200+20, x*200+200-20, y*200+200-20);
  line(x*200+200-20, y*200+20, x*200+20, y*200+200-20);
}

// Se dibuja graficamente el circulo
void drawO(int x, int y){
  fill(192,192,192);
  ellipse(x*200+100, y*200+100, 160, 160);
}

// Aqui se dibuja graficamente en el tablero si el jugador coloco o la IA, la IA coloca el -1 y el jugador el 1
void locator(int x, int y){
  if (board[y][x] == 1) // Jugada del jugador
    drawX(x, y);
  if (board[y][x] == -1) // Jugada de la IA
    drawO(x, y);
}

// Aqui se envia al locator en que cordenadas fue la jugada
void drawMarks(){
  for(int y = 0; y < 3; y++){
    for(int x = 0; x < 3; x++){
      locator(x, y);
    }
  }
}

// Esta funcion revisa si ya hay algun ganador
void check(){ 
  for(int i = 0; i < 3; i++){
    // Validacion para jugador
    if(board[i][0] == board[i][1] && board[i][0] == board[i][2] && board[i][0] == 1)
      winner = 1;
    if(board[0][i] == board[1][i] && board[0][i] == board[2][i] && board[0][i] == 1)
      winner = 1;
    if(board[0][0] == board[1][1] && board[0][0] == board[2][2] && board[0][0] == 1)
      winner = 1;
    if(board[0][2] == board[1][1] && board[0][2] == board[2][0] && board[0][2] == 1)
      winner = 1;
    // Validacion para IA
    if(board[i][0] == board[i][1] && board[i][0] == board[i][2] && board[i][0] == -1)
      winner = 2;
    if(board[0][i] == board[1][i] && board[0][i] == board[2][i] && board[0][i] == -1)
      winner = 2;
    if(board[0][0] == board[1][1] && board[0][0] == board[2][2] && board[0][0] == -1)
      winner = 2;
    if(board[0][2] == board[1][1] && board[0][2] == board[2][0] && board[0][2] == -1)
      winner = 2;
  }
}
    
// Esta funcion checa si la IA puede ganar
public boolean checkWinIA(){
  // Victorias horizontales
  for(int i = 0; i < 3; i++){
    if(board[i][0] == -1 && board[i][1] == -1 && board[i][2] == 0){
      board[i][2] = -1;
      return true;
    }
    if(board[i][1] == -1 && board[i][2] == -1 && board[i][0] == 0){
      board[i][0] = -1;
      return true;
    }
    if(board[i][0] == -1 && board[i][2] == -1 && board[i][1] == 0){
      board[i][1] = -1;
      return true;
    }
  }
  // Victorias verticales
  for(int i = 0; i < 3; i++){
    if(board[0][i] == -1 && board[1][i] == -1 && board[2][i] == 0){
      board[2][i] = -1;
      return true;
    }
    if(board[1][i] == -1 && board[2][i] == -1 && board[0][i] == 0){
      board[0][i] = -1;
      return true;
    }
    if(board[0][i] == -1 && board[2][i] == -1 && board[1][i] == 0){
      board[1][i] = -1;
      return true;
    }
  }
  // Victorias cruzadas
  if(board[0][0] == -1 && board[1][1] == -1 && board[2][2] == 0){
    board[2][2] = -1;
    return true;
  }
  if(board[1][1] == -1 && board[2][2] == -1 && board[0][0] == 0){
    board[0][0] = -1;
    return true;
  }
  if(board[0][0] == -1 && board[2][2] == -1 && board[1][1] == 0){
    board[1][1] = -1;
    return true;
  }
  if(board[0][2] == -1 && board[1][1] == -1 && board[2][0] == 0){
    board[2][0] = -1;
    return true;
  }
  if(board[1][1] == -1 && board[2][0] == -1 && board[0][2] == 0){
    board[0][2] = -1;
    return true;
  }
  if(board[0][2] == -1 && board[2][0] == -1 && board[1][1] == 0){
    board[1][1] = -1;
    return true;
  }
  return false;
}

// Esta funcion revisa si la IA puede bloquear
public boolean checkBlockIA(){
  // Bloqueos horizontales
  for(int i = 0; i < 3; i++){
    if(board[i][0] == 1 && board[i][1] == 1 && board[i][2] == 0){
      board[i][2] = -1;
      return true;
    }
    if(board[i][1] == 1 && board[i][2] == 1 && board[i][0] == 0){
      board[i][0] = -1;
      return true;
    }
    if(board[i][0] == 1 && board[i][2] == 1 && board[i][1] == 0){
      board[i][1] = -1;
      return true;
    }
  }
  // Bloqueos verticales
  for(int i = 0; i < 3; i++){
    if(board[0][i] == 1 && board[1][i] == 1 && board[2][i] == 0){
      board[2][i] = -1;
      return true;
    }
    if(board[1][i] == 1 && board[2][i] == 1 && board[0][i] == 0){
      board[0][i] = -1;
      return true;
    }
    if(board[0][i] == 1 && board[2][i] == 1 && board[1][i] == 0){
      board[1][i] = -1;
      return true;
    }
  }
  // Bloqueos cruzadas
  if(board[0][0] == 1 && board[1][1] == 1 && board[2][2] == 0){
    board[2][2] = -1;
    return true;
  }
  if(board[1][1] == 1 && board[2][2] == 1 && board[0][0] == 0){
    board[0][0] = -1;
    return true;
  }
  if(board[0][0] == 1 && board[2][2] == 1 && board[1][1] == 0){
    board[1][1] = -1;
    return true;
  }
  if(board[0][2] == 1 && board[1][1] == 1 && board[2][0] == 0){
    board[2][0] = -1;
    return true;
  }
  if(board[1][1] == 1 && board[2][0] == 1 && board[0][2] == 0){
    board[0][2] = -1;
    return true;
  }
  if(board[0][2] == 1 && board[2][0] == 1 && board[1][1] == 0){
    board[1][1] = -1;
    return true;
  }
  return false;
}

// Aqui es donde la IA juega




// Esta funcion revisa si empieza segundo la IA
void blockPlayIA(){
  num1 = (int)(Math.random()*3);
  num2 = (int)(Math.random()*3);
  if(aux == 1){
    if(checkWinIA())
      System.out.println("WIN IA");
    else if(checkBlockIA())
      System.out.println("BLOCK IA");
    else if(board[num1][num2] == 0)
      board[num1][num2] = -1;
    else if(board[num1][num2] != 0){
      aux2 = 1;
      while(aux2 == 1){
        if(aux == 1){
          num1 = (int)(Math.random()*3);
          num2 = (int)(Math.random()*3);
          if(board[num1][num2] == 0){
            board[num1][num2] = -1;
            aux2 = 0;
          }
        }
      }
    }
  }
  
  if(aux == 0){
    if(board[1][1] == 0){
        board[1][1] = -1;
        aux = 1;
    } else 
        switch(board_Choose){
          case 0:
            board[0][0] = -1;
            break;
          case 1:
            board[0][2] = -1;
            break;
          case 2:
            board[2][0] = -1;
            break;
          case 3:
            board[2][2] = -1;
            break;
        }
        aux = 1;
  }
}


// Función que determina si el juego ha terminado y quién es el ganador
void checkGameEnd() {
  check();
  if (winner == 1) {
    msg = "¡Has ganado!";
  } else if (winner == 2) {
    msg = "¡Has perdido!";
  } else if (shifts == 9) {
    msg = "¡Empate!";
  }
}

int minimax(int depth, int turn) {
  if (checkWinIA()) {
    return -1;
  }
  if (checkBlockIA()) {
    return 1;
  }
  if (shifts == 9) {
    return 0;
  }

  int bestScore;
  if (turn == IA) {
    bestScore = Integer.MIN_VALUE;
    for (int i = 0; i < 3; i++) {
      for (int j = 0; j < 3; j++) {
        if (board[i][j] == 0) {
          board[i][j] = IA;
          shifts++;
          int score = minimax(depth + 1, player);
          board[i][j] = 0;
          shifts--;
          bestScore = max(score, bestScore);
        }
      }
    }
  } else {
    bestScore = Integer.MAX_VALUE;
    for (int i = 0; i < 3; i++) {
      for (int j = 0; j < 3; j++) {
        if (board[i][j] == 0) {
          board[i][j] = player;
          shifts++;
          int score = minimax(depth + 1, IA);
          board[i][j] = 0;
          shifts--;
          bestScore = min(score, bestScore);
        }
      }
    }
  }

  return bestScore;
}

// Función para que la IA realice su jugada usando el algoritmo Minimax
void playIA() {
  int bestScore = Integer.MIN_VALUE;
  int bestX = -1;
  int bestY = -1;

  for (int i = 0; i < 3; i++) {
    for (int j = 0; j < 3; j++) {
      if (board[i][j] == 0) {
        board[i][j] = IA;
        shifts++;
        int score = minimax(0, player);
        board[i][j] = 0;
        shifts--;
        if (score > bestScore) {
          bestScore = score;
          bestX = j;
          bestY = i;
        }
      }
    }
  }

  if (bestX != -1 && bestY != -1) {
    board[bestY][bestX] = IA;
  }
}

// Esta funciona revisa si sigue el jugador o la IA y quien empieza
void validate(){
  // Empieza el jugador
  if(num_Start == 0){
    x = mouseX;
    y = mouseY;
    y = y/200;
    x = x/200;
    if(board[y][x] == 0){
      board[y][x] = player;
      if(cont <= 3)
        blockPlayIA();
      cont++;
      cont2+=2;
    }
  }
  // Empieza la IA
  if(num_Start == 1){
    if(shifts == 0){
      playIA();
      shifts = 1;
    }
    if(shifts == 1 && mousePressed){
      x = mouseX;
      y = mouseY;
      y = y/200;
      x = x/200;
      if(board[y][x] == 0){
        board[y][x] = player;
        shifts = 0;
        cont2+=2;
      }
    }
  }
}

// Esta funcion declara si el jugador gano contra la IA, perdio o empato
void declare(){
  if(winner == 1){
    textFont(f, 80);
    fill(255,215,0);
    textAlign(CENTER);
    msg = "GANASTE";
    text(msg, 300, 300);
  }
  if(winner == 2){
    textFont(f, 80);
    fill(255,0,0);
    textAlign(CENTER);
    msg = "PERDISTE";
    text(msg, 300, 300);
   }
   if(winner == 0 && cont2+num_Start >= 9){
    textFont(f, 80);
    fill(255,0,0);
    textAlign(CENTER);
    msg = "EMPATE";
    text(msg, 300, 300);
   }
}

void draw(){
  background(192,192,192);
  drawBoard();
  drawMarks();
  if(mousePressed && num_Start == 0)
    validate();
  if(num_Start == 1)
    validate();
  check();
  declare();
}
