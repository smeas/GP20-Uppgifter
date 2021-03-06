class Human extends Character {
	private static final float SIZE_VARIATION = 2;
	private static final int COLOR_VARIATION = 30;
	private static final float MIN_WALK_DISTANCE = 50;
	private static final float MAX_WALK_DISTANCE = 200;
	private static final float TURNING_SPEED = PI/2 * 1.2f; // 90°/s

	private float targetDistance;
	private PVector targetDirection = new PVector();
	private float currentDistance;

	public Human() {
		super();
		radius += random(-SIZE_VARIATION, SIZE_VARIATION);
		velocity = randomDirection().mult(HUMAN_SPEED);
		_color = color(255 + random(-COLOR_VARIATION, COLOR_VARIATION),
		               219 + random(-COLOR_VARIATION, COLOR_VARIATION),
		               143 + random(-COLOR_VARIATION, COLOR_VARIATION));
	}

	@Override
	public void update(float dt) {
		super.update(dt);

		currentDistance += velocity.mag() * dt;
		if (currentDistance >= targetDistance)
			selectNewTarget();

		// Rotate towards the target direction.
		float currentAngle = atan2(velocity.y, velocity.x);
		float targetAngle = currentAngle + signedAngleBetween(velocity, targetDirection);
		velocity.rotate(moveTowards(currentAngle, targetAngle, TURNING_SPEED * dt) - currentAngle);
	}

	@Override
	protected void drawCharacter() {
		super.drawCharacter();

		// Draw eyes.
		fill(0);
		float eyeScale = 4 * (radius / 10);
		ellipse(radius - 5, eyeScale, eyeScale, eyeScale);
		ellipse(radius - 5, -eyeScale, eyeScale, eyeScale);
	}

	private void selectNewTarget() {
		currentDistance = 0;
		targetDistance = random(MIN_WALK_DISTANCE, MAX_WALK_DISTANCE);
		targetDirection.set(velocity).rotate(random(-PI/2, PI/2));
	}
}
