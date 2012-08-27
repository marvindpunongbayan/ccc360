class ApplyQeNamespaceToPrElements < ActiveRecord::Migration
  def up
		Qe::Element.all.each do |e|
			# In order to use the Qe namespace conventions
			# QuestionGrid => Qe::QuestionGrid 
			# question_grid => qe/question_grid
			kind_new = 'Qe::' + e.kind
			style_new = 'qe/' + e.style
			namespaced = { kind: kind_new, style: style_new }
			e.attributes = e.attributes.merge(namespaced)

			e.save(:validate => false) # false skips model validations
		end
  end

  def down
  	# reverse the namespace conventions
  	Qe::Element.all.each do |e|
  		kind_old = e.kind.split(/Qe::/).second
			style_old = e.style.split(/qe\//).second
			non_ns = { kind: kind_old, style: style_old }
			e.attributes = e.attributes.merge(non_ns)
  		
  		e.save(:validate => false)
  	end
  end
end
