mod day_01;
mod day_02;
mod day_03;
mod day_04;
mod day_05;
mod day_06;
mod day_07;
mod day_08;
mod day_09;

use clap::Parser;
use std::{error::Error, fs::read_to_string, path::PathBuf};

type Part = Box<dyn Fn(&str) -> String>;
type Day = (Part, Part);

#[derive(Parser, Debug)]
struct Arguments {
    day: u8,
    input_file_path: PathBuf,
}

fn main() -> Result<(), Box<dyn Error>> {
    let args = Arguments::parse();
    let input = read_to_string(args.input_file_path)?;

    let sols: Vec<Day> = vec![
        (Box::new(day_01::part1), Box::new(day_01::part2)),
        (Box::new(day_02::part1), Box::new(day_02::part2)),
        (Box::new(day_03::part1), Box::new(day_03::part2)),
        (Box::new(day_04::part1), Box::new(day_04::part2)),
        (Box::new(day_05::part1), Box::new(day_05::part2)),
        (Box::new(day_06::part1), Box::new(day_06::part2)),
        (Box::new(day_07::part1), Box::new(day_07::part2)),
        (Box::new(day_08::part1), Box::new(day_08::part2)),
        (Box::new(day_09::part1), Box::new(day_09::part2)),
    ];

    let (part1, part2) = &sols[(args.day - 1) as usize];

    println!("Part1: {}\nPart2: {}", part1(&input), part2(&input));

    Ok(())
}
