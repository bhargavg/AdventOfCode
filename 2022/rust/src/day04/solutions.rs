use std::ops::RangeInclusive;

use advent_of_code::Solution;

pub struct Day04 {}

impl Day04 {
    pub fn new() -> Self {
        Self {}
    }
}

impl Solution for Day04 {
    fn problem_number(&self) -> i32 {
        4
    }

    fn part1(&self, input: &str) -> String {
        helper(input, is_range_contains_other)
    }

    fn part2(&self, input: &str) -> String {
        helper(input, is_range_overlaps_other)
    }
}

fn helper<F>(input: &str, filter_condition: F) -> String
where
    F: Fn(&RangeInclusive<i32>, &RangeInclusive<i32>) -> bool,
{
    input
        .lines()
        .filter(|line| !line.is_empty())
        .map(parse_line)
        .filter(|(left, right)| filter_condition(left, right))
        .count()
        .to_string()
}

fn parse_range(range: &str) -> RangeInclusive<i32> {
    let (left, right) = range.split_once('-').unwrap();
    RangeInclusive::new(left.parse::<i32>().unwrap(), right.parse::<i32>().unwrap())
}

fn parse_line(line: &str) -> (RangeInclusive<i32>, RangeInclusive<i32>) {
    let (left, right) = line.split_once(',').unwrap();
    (parse_range(left), parse_range(right))
}

fn is_range_contains_other(r1: &RangeInclusive<i32>, r2: &RangeInclusive<i32>) -> bool {
    (r1.contains(r2.start()) && r1.contains(r2.end()))
        || (r2.contains(r1.start()) && r2.contains(r1.end()))
}

fn is_range_overlaps_other(r1: &RangeInclusive<i32>, r2: &RangeInclusive<i32>) -> bool {
    (r1.contains(r2.start()) || r1.contains(r2.end()))
        || (r2.contains(r1.start()) || r2.contains(r1.end()))
}

#[cfg(test)]
mod tests {
    use super::*;

    const INPUT: &str = r"2-4,6-8
2-3,4-5
5-7,7-9
2-8,3-7
6-6,4-6
2-6,4-8
";

    #[test]
    fn test_part1_example() {
        let day04 = Day04::new();
        assert_eq!(day04.part1(INPUT), "2");
    }

    #[test]
    fn test_part2_example() {
        let day04 = Day04::new();
        assert_eq!(day04.part2(INPUT), "4");
    }
}
