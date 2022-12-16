use std::str::FromStr;

pub(crate) struct Cd {
    pub(crate) destination: CdDestination,
}
impl FromStr for Cd {
    type Err = String;

    fn from_str(s: &str) -> Result<Self, Self::Err> {
        let (_, destination) = s
            .split_once("cd ")
            .ok_or(format!("Unable to parse cd command: {s}"))?;

        Ok(Cd {
            destination: destination.parse()?,
        })
    }
}

pub(crate) enum CdDestination {
    Parent,
    Root,
    Dir(String),
}

impl FromStr for CdDestination {
    type Err = String;

    fn from_str(s: &str) -> Result<Self, Self::Err> {
        if s == "/" {
            Ok(CdDestination::Root)
        } else if s == ".." {
            Ok(CdDestination::Parent)
        } else {
            Ok(CdDestination::Dir(s.to_owned()))
        }
    }
}
