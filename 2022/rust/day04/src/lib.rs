use std::env;
use std::fs;
use std::ops::RangeInclusive;

fn read_file(name: &str) -> String {
    let file_path = env::current_dir().unwrap().join("inputs").join(name);
    fs::read_to_string(&file_path).unwrap_or(format!("Unable to read file at: {:?}", &file_path))
}

fn parse_range(range: &str) -> RangeInclusive<i32> {
    let (left, right) = range.split_once("-").unwrap();
    RangeInclusive::new(left.parse::<i32>().unwrap(), right.parse::<i32>().unwrap())
}

fn parse_line(line: &str) -> (RangeInclusive<i32>, RangeInclusive<i32>) {
    let (left, right) = line.split_once(",").unwrap();
    (parse_range(left), parse_range(right))
}

fn parse<'a>(
    input: &'a str,
) -> impl Iterator<Item = (RangeInclusive<i32>, RangeInclusive<i32>)> + 'a {
    input
        .lines()
        .filter(|line| !line.is_empty())
        .map(parse_line)
}

fn is_range_contains_other(r1: &RangeInclusive<i32>, r2: &RangeInclusive<i32>) -> bool {
    (r1.contains(r2.start()) && r1.contains(r2.end()))
        || (r2.contains(r1.start()) && r2.contains(r1.end()))
}

fn is_range_overlaps_other(r1: &RangeInclusive<i32>, r2: &RangeInclusive<i32>) -> bool {
    (r1.contains(r2.start()) || r1.contains(r2.end()))
        || (r2.contains(r1.start()) || r2.contains(r1.end()))
}

fn part1(input: &str) -> usize {
    parse(input)
        .filter(|(left, right)| is_range_contains_other(left, right))
        .count()
}

fn part2(input: &str) -> usize {
    parse(input)
        .filter(|(left, right)| is_range_overlaps_other(left, right))
        .count()
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn test_part1_example() {
        let contents = read_file("part1_example.txt");
        assert_eq!(part1(&contents), 2);
    }

    #[test]
    fn test_part1() {
        let contents = read_file("part1.txt");
        assert_eq!(part1(&contents), 456);
    }

    #[test]
    fn test_part2_example() {
        let contents = read_file("part2_example.txt");
        assert_eq!(part2(&contents), 4);
    }

    #[test]
    fn test_part2() {
        let contents = read_file("part2.txt");
        assert_eq!(part2(&contents), 808);
    }
}
