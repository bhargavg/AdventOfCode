use advent_of_code::Runner;

mod day01;
use day01::solutions::Day01;

mod day02;
use day02::v1::solutions::Day02;

mod day03;
use day03::solutions::Day03;

mod day04;
use day04::solutions::Day04;

mod day05;
use day05::solutions::Day05;

mod day06;
use day06::solutions::Day06;

fn main() {
    let runner = Runner::new(vec![
        Box::new(Day01::new()),
        Box::new(Day02::new()),
        Box::new(Day03::new()),
        Box::new(Day04::new()),
        Box::new(Day05::new()),
        Box::new(Day06::new()),
    ]);

    runner.run();
}
