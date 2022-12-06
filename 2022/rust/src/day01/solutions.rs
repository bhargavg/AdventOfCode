use advent_of_code::Solution;

pub struct Day01 {}

impl Day01 {
    pub fn new() -> Self {
        Self {}
    }
}

impl Day01 {
    fn helper(&self, input: &str, count: usize) -> i32 {
        let mut groups = input
            .split("\n\n")
            .map(|lines| {
                lines
                    .lines()
                    .map(|line| line.trim())
                    .filter(|line| !line.is_empty())
                    .map(|line| line.parse::<i32>().unwrap())
                    .sum::<i32>()
            })
            .collect::<Vec<i32>>();

        groups.sort();

        groups.iter().rev().take(count).sum()
    }
}

impl Solution for Day01 {
    fn problem_number(&self) -> i32 {
        1
    }

    fn part1(&self, input: &str) -> String {
        self.helper(input, 1).to_string()
    }

    fn part2(&self, input: &str) -> String {
        self.helper(input, 3).to_string()
    }
}

#[cfg(test)]
mod tests {
    use advent_of_code::Solution;

    use super::*;

    const INPUT: &str = r"1000
2000
3000

4000

5000
6000

7000
8000
9000

10000
";

    #[test]
    fn test_part_1_example() {
        let day01 = Day01::new();
        assert_eq!(day01.part1(INPUT), "24000");
    }

    #[test]
    fn test_part_2_example() {
        let day01 = Day01::new();
        assert_eq!(day01.part2(INPUT), "45000");
    }
}
