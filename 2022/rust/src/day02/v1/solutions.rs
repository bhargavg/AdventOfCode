use advent_of_code::Solution;

use super::{outcome::Outcome, shape::Shape};

pub struct Day02 {}

impl Day02 {
    pub fn new() -> Self {
        Self {}
    }
}

impl Solution for Day02 {
    fn problem_number(&self) -> i32 {
        2
    }

    fn part1(&self, input: &str) -> String {
        self.parse(input)
            .map(|(x, y)| (Shape::from(x), Shape::from(y)))
            .map(|players| self.compute_score(players))
            .sum::<u32>()
            .to_string()
    }

    fn part2(&self, input: &str) -> String {
        self.parse(input)
            .map(|(x, y)| (Outcome::from(x), Shape::from(y)))
            .map(|(outcome, player2)| (self.compute_shape(&player2, &outcome), player2))
            .map(|players| self.compute_score(players))
            .sum::<u32>()
            .to_string()
    }
}

impl Day02 {
    fn parse<'a>(&self, input: &'a str) -> impl Iterator<Item = (&'a str, &'a str)> + 'a {
        input.split('\n').map(|l| {
            let mut comps = l.split(' ');
            let player2 = comps.next().unwrap();
            let player1 = comps.next().unwrap();
            (player1, player2)
        })
    }

    fn compute_score(&self, players: (Shape, Shape)) -> u32 {
        let (player1, player2) = players;
        self.win_score(&player1, &player2) + self.shape_score(&player1)
    }

    fn win_score(&self, player1: &Shape, player2: &Shape) -> u32 {
        self.score_for_outcome(&Outcome::from_play(player1, player2))
    }

    fn shape_score(&self, player1: &Shape) -> u32 {
        match player1 {
            Shape::Rock => 1,
            Shape::Paper => 2,
            Shape::Scissors => 3,
        }
    }

    fn score_for_outcome(&self, outcome: &Outcome) -> u32 {
        match outcome {
            Outcome::Win => 6,
            Outcome::Draw => 3,
            Outcome::Loose => 0,
        }
    }

    fn compute_shape(&self, player: &Shape, outcome: &Outcome) -> Shape {
        match outcome {
            Outcome::Draw => *player,
            Outcome::Loose => match player {
                Shape::Rock => Shape::Scissors,
                Shape::Paper => Shape::Rock,
                Shape::Scissors => Shape::Paper,
            },
            Outcome::Win => match player {
                Shape::Rock => Shape::Paper,
                Shape::Paper => Shape::Scissors,
                Shape::Scissors => Shape::Rock,
            },
        }
    }
}

#[cfg(test)]
mod tests {
    use advent_of_code::Solution;

    use super::Day02;

    const INPUT: &str = r"A Y
B X
C Z";

    #[test]
    fn test_part_1_example() {
        let day01 = Day02::new();
        assert_eq!(day01.part1(INPUT), "15");
    }

    #[test]
    fn test_part_2_example() {
        let day01 = Day02::new();
        assert_eq!(day01.part2(INPUT), "12");
    }
}
