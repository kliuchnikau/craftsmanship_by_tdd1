class TowerOfHanoi
	def initialize
		@rods = [[], [], []]
	end

	def get_rod index
		validate_rod_index index
		@rods[index-1]
	end

	def set_rod index, value
		validate_rod_index index
		@rods[index-1] = value
	end

	def setup amount
		amount.times do |i|
			self.get_rod(1) << amount - i
		end
	end

	def move(from_rod, to_rod)
		topmost_dice_on1 = get_rod(from_rod).pop
		get_rod(to_rod) << topmost_dice_on1
	end

	def can_move?(from_rod, to_rod)
		from_rod_last = get_rod(from_rod).last
		to_rod_last = get_rod(to_rod).last
		return false if from_rod_last.nil?
		return true if to_rod_last.nil?
		from_rod_last < to_rod_last
	end

	def step
		(1..amount).each { |goal_id|
			current_goal = goal goal_id

		}

		if can_move?(1, 2) and can_move?(1, 3)
			move(1, 3)
		end
	end

	def goal step_index
		amount = self.amount

		if even?(amount)
			even?(step_index) ? 3 : 2
		else
			even?(step_index) ? 2 : 3
		end
	end

	def amount
		@rods.inject(0) do |memo, i|
			memo += i.size
		end
	end

	private
	def even? num
		num % 2 == 0
	end

	def validate_rod_index index
		raise "Invalid index: #{index}" if index < 1 or index > 3
	end

end