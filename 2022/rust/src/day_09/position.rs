use super::direction::Direction;

#[derive(Debug, Default, Copy, Clone, PartialEq, Eq, Hash)]
pub(crate) struct Position {
    pub(crate) x: i32,
    pub(crate) y: i32,
}

impl Position {
    pub(crate) fn move_in_direction(&mut self, dir: &Direction) {
        match dir {
            Direction::Right => self.x += 1,
            Direction::Down => self.y -= 1,
            Direction::Left => self.x -= 1,
            Direction::Up => self.y += 1,
        }
    }
}
