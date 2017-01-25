String lines[];
PrintWriter output;

int i = 0;

void inputEnter(String NAME){
  String[] newdata = appendScore(lines, NAME, score);
  outputData(newdata, output);
}
String[] appendScore(String[] data, String Name, int Score){
  data = append(data, Name + " " + str(Score));
  return data;
}
void outputData(String[] NEWDATA, PrintWriter OUTPUT){
  if(i<1){
    String FINAL = join(NEWDATA, " ");
    OUTPUT.println((FINAL));
    i++;
  }
  OUTPUT.flush();
  OUTPUT.close();
  exit();
}