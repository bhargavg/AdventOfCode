use std::collections::btree_set::Intersection;
use std::collections::HashMap;
use std::collections::HashSet;
use std::env;
use std::fs;

fn read_file(name: &str) -> String {
    let file_path = env::current_dir().unwrap().join("inputs").join(name);
    fs::read_to_string(&file_path).unwrap_or(format!("Unable to read file at: {:?}", &file_path))
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

fn parse<'a>(input: &'a str) -> impl Iterator<Item = String> + 'a {
    input
        .lines()
        .filter(|l| !l.is_empty())
        .clone()
        .map(|l| l.to_owned())
}

fn part1(input: &str) -> u32 {
    parse(input)
        .map(|line| split_into_compartments(&line))
        .map(|compartments| get_common_character(compartments.into_iter()))
        .map(|char| character_priority(&char))
        .sum::<u32>()
}

fn part2(input: &str) -> u32 {
    parse(input)
        .collect::<Vec<String>>()
        .chunks(3)
        .map(|chunk| get_common_character(chunk.iter().cloned()))
        .map(|char| character_priority(&char))
        .sum::<u32>()
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn test_part1_example() {
        let contents = read_file("part1_example.txt");
        assert_eq!(part1(&contents), 157);
    }

    #[test]
    fn test_part1() {
        let contents = read_file("part1.txt");
        assert_eq!(part1(&contents), 8072);
    }

    #[test]
    fn test_part2_example() {
        let contents = read_file("part2_example.txt");
        assert_eq!(part2(&contents), 70);
    }

    #[test]
    fn test_part2() {
        let contents = read_file("part2.txt");
        assert_eq!(part2(&contents), 2567);
    }
}
