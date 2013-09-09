Puntuation numPoints = new Puntuation();

public class Puntuation {
  private int points;

    public Puntuation()
  {
    points = 0;
  }

  public void clearPuntuation()
  {
    points = 0;
  }

  public void addPuntuation(int add)
  {
    points += add;
  }

  public int getPuntuation()
  {
    return points;
  }
}

