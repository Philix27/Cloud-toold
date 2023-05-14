use std::{io, cmp::Ordering};
use rand::Rng

fn main() {
    println!("Guess the number");
    println!("Input your guess");

    let  capacity = String::with_capacity(10);
    let mut guess_value = String::new();
    io::stdin()
        .read_line(&mut guess_value)
        .expect("Ops an error occure");
    print!("Your guess {guess_value}");
    print!("Capacity: {}", capacity);
    
    let a_num = 598;
    let secret_number = 708;

    match a_num.cmp(&secret_number) {
        Ordering::Greater =>  print!("Is greater than"),
        Ordering::Less =>  print!("A lesser number")
    }
}
