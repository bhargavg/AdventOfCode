mod shape;
use shape::Shape;

mod outcome;
use outcome::Outcome;

pub(crate) fn part1(input: &str) -> String {
    parse(input)
        .map(|(x, y)| (Shape::from(x), Shape::from(y)))
        .map(|players| compute_score(players))
        .sum::<u32>()
        .to_string()
}

pub(crate) fn part2(input: &str) -> String {
    parse(input)
        .map(|(x, y)| (Outcome::from(x), Shape::from(y)))
        .map(|(outcome, player2)| (compute_shape(&player2, &outcome), player2))
        .map(|players| compute_score(players))
        .sum::<u32>()
        .to_string()
}

fn parse<'a>(input: &'a str) -> impl Iterator<Item = (&'a str, &'a str)> + 'a {
    input.split('\n').map(|l| {
        let mut comps = l.split(' ');
        let player2 = comps.next().unwrap();
        let player1 = comps.next().unwrap();
        (player1, player2)
    })
}

fn compute_score(players: (Shape, Shape)) -> u32 {
    let (player1, player2) = players;
    win_score(&player1, &player2) + shape_score(&player1)
}

fn win_score(player1: &Shape, player2: &Shape) -> u32 {
    score_for_outcome(&Outcome::from_play(player1, player2))
}

fn shape_score(player1: &Shape) -> u32 {
    match player1 {
        Shape::Rock => 1,
        Shape::Paper => 2,
        Shape::Scissors => 3,
    }
}

fn score_for_outcome(outcome: &Outcome) -> u32 {
    match outcome {
        Outcome::Win => 6,
        Outcome::Draw => 3,
        Outcome::Loose => 0,
    }
}

fn compute_shape(player: &Shape, outcome: &Outcome) -> Shape {
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

#[cfg(test)]
mod tests {
    use super::*;

    const INPUT: &str = r"A Y
B X
C Z";

    #[test]
    fn test_part_1_example() {
        assert_eq!(part1(INPUT), "15");
    }

    #[test]
    fn test_part_2_example() {
        assert_eq!(part2(INPUT), "12");
    }
}
