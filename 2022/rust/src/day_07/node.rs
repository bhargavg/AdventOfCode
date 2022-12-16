use core::fmt;
use std::{cell::RefCell, collections::HashMap, rc::Rc};

type NodeHandle = Rc<RefCell<Node>>;

#[derive(Default)]
pub(crate) struct Node {
    pub(crate) size: usize,
    pub(crate) children: HashMap<String, NodeHandle>,
    pub(crate) parent: Option<NodeHandle>,
}

impl fmt::Debug for Node {
    fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
        f.debug_struct("Node")
            .field("size", &self.size)
            .field("children", &self.children)
            .finish()
    }
}

impl Node {
    pub(crate) fn is_dir(&self) -> bool {
        self.size == 0 && !self.children.is_empty()
    }
    pub(crate) fn total_size(&self) -> usize {
        self.size
            + self
                .children
                .values()
                .map(|child| child.borrow().total_size())
                .sum::<usize>()
    }
}
