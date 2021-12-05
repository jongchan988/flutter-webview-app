
void main(){
  Car bmw = new Car(320, 100000, 'BMW');
  Car bnz = new Car(320, 100000, 'BENZ');
  Car ford = new Car(320, 100000, 'FORD');

  bmw.saleCar();
  bmw.saleCar();
  bmw.saleCar();
  print(bmw.price);
}

class Car {
  int maxSpeed;
  num price;
  String name;

  Car(this.maxSpeed, this.price, this.name);

  num saleCar(){
    this.price = price * 0.9;
    return price;
  }
}