require 'rails_helper'

describe Video do
	it { should belong_to(:category)}
	it { should validate_presence_of(:title)}
	it { should validate_presence_of(:description)}
	it { should have_many (:reviews).order("created_at DESC")}
end

describe Video do
	#it { should belong_to(:category)}
	#it { should validate_presence_of(:title)}
	#it { should validate_presence_of(:description)}

	describe "search_by_title" do
		it "returns an empty array if there is no match" do
			cat = Category.create(name: "fun")
			futurama = Video.create(title: "futurama", description: "space travel!", category: cat)
			back_to_future = Video.create(title: "Back to future", description: "time travel!", category: cat)
			expect(Video.search_by_title("hello")).to eq([])
			
		end
		it "returns an array of one video for an exact match" do
			cat = Category.create(name: "fun")
			futurama = Video.create(title: "futurama", description: "space travel!", category: cat)
			back_to_future = Video.create(title: "Back to future", description: "time travel!", category: cat)
			expect(Video.search_by_title("futurama").records.to_a).to eq([futurama])	
		end
		it "returns an array of one video for a partial match" do
			cat = Category.create(name: "fun")
			futurama = Video.create(title: "futurama", description: "space travel!", category: cat)
			back_to_future = Video.create(title: "Back to future", description: "time travel!", category: cat)
			v = Video.search_by_title("urama")
			expect(v).to eq([futurama])
		end
		
		it "returns an array of all matches ordered by created_at" do
			cat = Category.create(name: "fun")
			futurama = Video.create(title: "futurama", description: "space travel!", category: cat, created_at: 1.day.ago)
			back_to_future = Video.create(title: "Back to future", description: "time travel!", category: cat)
			expect(Video.search_by_title("futur").all).to eq([back_to_future, futurama])
		end
	
		it "returns an empty array for a search with an empty string" do
			cat = Category.create(name: "fun")
			futurama = Video.create(title: "futurama", description: "space travel!", category: cat, created_at: 1.day.ago)
			back_to_future = Video.create(title: "Back to future", description: "time travel!", category: cat)
			expect(Video.search_by_title("")).to eq([])

		end
	end
end

