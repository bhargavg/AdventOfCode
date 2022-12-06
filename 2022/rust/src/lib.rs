use std::env;
use std::fs;

pub trait Solution {
    fn problem_number(&self) -> i32;

    fn load_file(&self) -> String {
        let problem_number = self.problem_number();

        let file_path = env::current_dir()
            .unwrap()
            .join("inputs")
            .join(format!("day{:0>2}.txt", problem_number));

        fs::read_to_string(&file_path)
            .unwrap_or(format!("Unable to read file at: {:?}", &file_path))
    }

    fn part1(&self, input: &str) -> String;
    fn run_part1(&self) -> String {
        let contents = self.load_file();
        self.part1(&contents)
    }

    fn part2(&self, input: &str) -> String;
    fn run_part2(&self) -> String {
        let contents = self.load_file();
        self.part2(&contents)
    }
}

pub struct Runner {
    solutions: Vec<Box<dyn Solution>>,
}

impl Runner {
    pub fn new(solutions: Vec<Box<dyn Solution>>) -> Self {
        Self { solutions }
    }

    pub fn run(&self) {
        for solution in &self.solutions {
            println!(
                "Day {}, Part1: {}",
                solution.problem_number(),
                solution.run_part1()
            );
            println!(
                "Day {}, Part2: {}",
                solution.problem_number(),
                solution.run_part2()
            );
        }
    }
}
