require_relative '../secret_santas'

describe Person do
  let(:person_string) { "Damon Butler <damon@madison.com>" }

  it "should correctly convert a formatted string into the Person object" do
    p = Person.new person_string
    p.fname.should == "Damon"
    p.lname.should == "Butler"
    p.email.should == "damon@madison.com"
  end
end

describe "Secret Santas" do
  let(:damon)  { Person.new "Damon Butler <damon@madison.com>" }
  let(:james)  { Person.new "James Butler <james@madison.com>" }
  let(:kathy)  { Person.new "Kathy Sliter <kathy@madison.com>" }
  let(:rob)    { Person.new "Rob Matsushita <rob@madison.com>" }
  let(:doug)   { Person.new "Doug Reed <doug@stoughton.com>" }
  let(:deanna) { Person.new "Deanna Reed <deanna@stoughton.com>" }
  let(:ilsa)   { Person.new "Ilsa Reed <ilsa@stoughton.com>" }
  let(:laszlo) { Person.new "Laszlo Reed <laszlo@stouhgton.com>" }
  let(:jenn)   { Person.new "Jenn Boelter <jenn@madison.com>" }

  let(:people) { [damon, james, kathy, rob, doug, deanna, ilsa, laszlo, jenn] }

  describe "group_santa_families" do
    it "should sort people by family, ordering them by the family size, from largest family to smallest" do
      people_grouped = group_santa_families(people)
      people_grouped.should == [doug, deanna, ilsa, laszlo, damon, james, rob, kathy, jenn]
    end
  end

  describe "match_with_santa" do
    context "secret santa: James" do
      it "should match a santa to a recipient not in the same family" do
        match, remaining = match_with_santa(james, people)
        [ damon, james ].include?(match).should == false
        remaining.include?(match).should == false
      end
    end
    context "secret santa: Ilsa" do
      it "should match a santa to a recipient not in the same family" do
        match, remaining = match_with_santa(ilsa, people)
        [ doug, deanna, ilsa, laszlo ].include?(match).should == false
        remaining.include?(match).should == false
      end
    end
  end

  describe "match_santas" do
    it "should match secret santas with recipients, without repeating any santas or recipients" do
      matched = match_santas(people)
      santas = matched.select{ |m| m[:santa] }
      santas.uniq.should == santas
      recipients = matched.select{ |m| m[:match] }
      recipients.uniq.should == recipients
    end
  end
end
