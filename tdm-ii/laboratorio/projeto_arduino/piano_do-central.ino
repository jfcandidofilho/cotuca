// Pino do transdutor de sons piezoelétrico (buzzer, para os íntimos)
const int SOM = 12; 

// Pinos dos botões 
const int B_DO  = 11;
const int B_RE  = 9;
const int B_MI  = 7;
const int B_FA  = 6;
const int B_SOL = 4;
const int B_LA  = 2;
const int B_SI  = 0;

// Notas musicais (frequência) em relação ao DÓ central do piano
const int DO  = 262;
const int RE  = 294;
const int MI  = 330;
const int FA  = 349;
const int SOL = 392;
const int LA  = 440;
const int SI  = 494;
    
void setup() {

  // Setup da saída de som
  pinMode( SOM, OUTPUT ); digitalWrite( SOM, LOW );

  // Setup da entrada de notas
  pinMode( B_DO, INPUT ); digitalWrite( B_DO, LOW );
  pinMode( B_RE, INPUT ); digitalWrite( B_RE, LOW );
  pinMode( B_MI, INPUT ); digitalWrite( B_MI, LOW );
  pinMode( B_FA, INPUT ); digitalWrite( B_FA, LOW );
  pinMode( B_SOL, INPUT ); digitalWrite( B_SOL, LOW );
  pinMode( B_LA, INPUT ); digitalWrite( B_LA, LOW );
  pinMode( B_SI, INPUT ); digitalWrite( B_SI, LOW );
  
}

void loop() {

  // LED interno aceso se nenhuma nota foi pressionada (padrão)
  digitalWrite( LED_BUILTIN, HIGH );
  

  // Se foi pressionado o DÓ...
  if( digitalRead( B_DO ) == HIGH ){

    // ... Faz o som do DÓ (com LED interno apagado) c/ delay de 0.2 segundos
    digitalWrite( LED_BUILTIN, LOW );
    tone( SOM, DO, 200 );   delay(200);

  } 


  // ... E assim sucessivamente para as demais notas! :)

  
  if( digitalRead( B_RE ) == HIGH ) {

    digitalWrite( LED_BUILTIN, LOW );
    tone( SOM, RE, 200 );   delay(200);
    
  }

  if( digitalRead( B_MI ) == HIGH ) {

    digitalWrite( LED_BUILTIN, LOW );
    tone( SOM, MI, 200 );   delay(200);
    
  } 
  
  if( digitalRead( B_FA ) == HIGH ) {

    digitalWrite( LED_BUILTIN, LOW );
    tone( SOM, FA, 200 );   delay(200);
    
  } 
  
  if( digitalRead( B_SOL ) == HIGH ) {

    digitalWrite( LED_BUILTIN, LOW );
    tone( SOM, SOL, 200 );   delay(200);
    
  } 
  
  if( digitalRead( B_LA ) == HIGH ) {

    digitalWrite( LED_BUILTIN, LOW );
    tone( SOM, LA, 200 );   delay(200);
    
  }

  if( digitalRead( B_SI ) == HIGH ) {

    digitalWrite( LED_BUILTIN, LOW );
    tone( SOM, SI, 200 );   delay(200);
    
  }
  
  
  
}
