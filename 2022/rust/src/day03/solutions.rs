use std::collections::HashSet;

use advent_of_code::Solution;

pub struct Day03 {}

impl Day03 {
    pub fn new() -> Self {
        Self {}
    }
}

impl Solution for Day03 {
    fn problem_number(&self) -> i32 {
        3
    }

    fn part1(&self, input: &str) -> String {
        input
            .lines()
            .map(split_into_compartments)
            .map(|compartments| get_common_character(compartments.into_iter()))
            .map(|char| character_priority(&char))
            .sum::<u32>()
            .to_string()
    }

    fn part2(&self, input: &str) -> String {
        input
            .lines()
            .map(|l| l.to_owned())
            .collect::<Vec<String>>()
            .chunks(3)
            .map(|chunk| get_common_character(chunk.iter().cloned()))
            .map(|char| character_priority(&char))
            .sum::<u32>()
            .to_string()
    }
}

fn split_into_compartments(input: &str) -> Vec<String> {
    let length = input.len();
    let (left, right) = input.split_at(length / 2);
    vec![left.to_owned(), right.to_owned()]
}

fn character_priority(char: &char) -> u32 {
    match char {
        'a'..='z' => (*char as u32) - ('a' as u32) + 1,
        'A'..='Z' => (*char as u32) - ('A' as u32) + 27,
        _ => panic!("Invalid character: {char}"),
    }
}

fn get_common_character(input: impl Iterator<Item = String>) -> char {
    let sets = &mut input.map(|s| s.chars().collect::<HashSet<_>>());

    let intersection = sets
        .next()
        .map(|set| sets.fold(set, |set1, set2| &set1 & &set2))
        .unwrap();

    intersection.iter().next().unwrap().to_owned()
}

#[cfg(test)]
mod tests {
    use advent_of_code::Solution;

    use super::*;

    const INPUT: &str = r"vJrwpWtwJgWrhcsFMMfFFhFp
jqHRNqRjqzjGDLGLrsFMfFZSrLrFZsSL
PmmdzqPrVvPwwTWBwg
wMqvLMZHhHMvwLHjbvcjnnSBnvTQFn
ttgJtRGJQctTZtZT
CrZsJsPPZsGzwwsLwLmpwMDw
";

    #[test]
    fn test_part_1_example() {
        let day03 = Day03::new();
        assert_eq!(day03.part1(INPUT), "157");
    }

    #[test]
    fn test_part_2_example() {
        let day03 = Day03::new();
        assert_eq!(day03.part2(INPUT), "70");
    }
}
