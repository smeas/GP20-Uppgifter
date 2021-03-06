class Cell {
	public boolean alive;
	public int age;

	public Cell[] neighbors = new Cell[NEIGHBOR_COUNT];

	public void setAlive(boolean value) {
		if (alive == value) return;
		alive = value;
		age = 0;
	}

	public void copyFrom(Cell other) {
		alive = other.alive;
		age = other.age;
	}
}