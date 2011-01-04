require "test/unit"
require "tower_of_hanoi"

class ClassTest < Test::Unit::TestCase
	def setup
	   	@tower = ::TowerOfHanoi.new

	end

	def teardown
	end

	def test_initially_empty_rods
		check_rods([], [], [])
	end

	def test_rods_setup
		@tower.setup 4
		assert_equal(4, @tower.get_rod(1).size, 'Should have 4 items')
		assert_equal(0, @tower.get_rod(2).size)
		assert_equal(0, @tower.get_rod(3).size)
	end

	def test_rod1_initialized_with_weights
		@tower.setup 4
		assert_equal([4,3,2,1], @tower.get_rod(1))
	end

	def test_can_move_disc
		setup_rods [3, 2, 1], [], []
		from_rod = 1
		to_rod = 2
		@tower.move(from_rod, to_rod)
		check_rods [3, 2], [1], []
	end

	def test_can_not_move_from_heavy_to_light
		setup_rods [], [3], [2]
		assert(@tower.can_move?(2, 3) == false)
	end

	def test_can_move_from_light_to_heavy
		setup_rods [], [3], [2]
		assert(@tower.can_move?(3, 2))
	end

	def test_can_not_move_from_empty_to_any
		setup_rods [], [3], [2]
		assert(@tower.can_move?(1, 2) == false)
	end

	def test_can_move_to_empty
		setup_rods [], [3], [2]
		assert(@tower.can_move?(2, 1))
	end

	def test_validate_index
		assert_raises RuntimeError do
			@tower.get_rod 0
		end
	end

	def test_if_can_move_to_2_and_3_move_3
		setup_rods [3, 2, 1], [], []
		@tower.step
		check_rods [3, 2], [], [1]
	end

	def test_initial_goal_odd
		@tower.setup 3
		assert(@tower.goal(1) == 3)
		assert(@tower.goal(2) == 2)
	end

	def test_initial_goal_even
		@tower.setup 4
		assert(@tower.goal(1) == 2)
		assert(@tower.goal(2) == 3)
	end

	def test_amount
		@tower.setup 9
		assert(@tower.amount == 9)
	end

	def test_amount_with_setup
		setup_rods([2,1],[],[3])
		assert_equal 3, @tower.amount
	end

	private
	def check_rods rod_1_val, rod_2_val, rod_3_val
		assert_equal(rod_1_val, @tower.get_rod(1))
		assert_equal(rod_2_val, @tower.get_rod(2))
		assert_equal(rod_3_val, @tower.get_rod(3))
	end

	def setup_rods rod_1_val, rod_2_val, rod_3_val
		@tower.set_rod(1, rod_1_val)
		@tower.set_rod(2, rod_2_val)
		@tower.set_rod(3, rod_3_val)
	end

end