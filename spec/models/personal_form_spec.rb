require 'spec_helper'

describe PersonalForm do
	before(:each) do
		@qs = QuestionSheet.create!(label: 'label')
	end
	describe 'AR relationships' do
		it 'question_sheets' do
			pf = @qs.personal_forms.create!
			pf.class.should be(PersonalForm)

			pf.question_sheets.count.should == 1
			pf.question_sheet.class.should be(QuestionSheet)
		end
	end
end