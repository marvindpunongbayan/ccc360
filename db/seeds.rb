EmailTemplate.create!( {
  :name => "Reviewer Invite", 
  :content => %|I want to thank you for your leadership and contribution to the mission God has given us. It is an exciting time to be involved in the Campus Ministry. Students' lives are being changed around the world. One of the greatest encouragements is His work in our lives, which is why I'm writing you and seeking your help.

It is our desire in the Campus Ministry to foster a "feedback rich" environment where all of us are getting regular input and feedback. In light of this I would greatly appreciate your filling out the review for {{ subject_name }}. This will be an important piece in {{ subject_pronoun }} ongoing development and growth. Your review will be kept confidential, and I would really appreciate your honest input.

All you need to do is click on the shortcut provided below and fill out the online form.

{{ review_url }}

If you could do this before {{ due_date }}, I would appreciate it.

In His grace,
{{ initiator_name }}|,
  :enabled => true,
  :subject => "{{review_name}} for {{subject_name}}" } )

EmailTemplate.create!( {
  :name => "Manual Reminder", 
  :content => %|manual reminder

{{subject_name}}
{{initiator_name}}
{{subject_pronoun}}
{{review_url}}
{{due_date}}|,
  :enabled => true,
  :subject => "manual reminder of {{review_name}} for {{subject_name}}" } )

EmailTemplate.create!( {
  :name => "7 Days Before",
  :content => %|7 days warning

{{subject_name}}
{{initiator_name}}
{{subject_pronoun}}
{{review_url}}
{{due_date}}|,
  :enabled => true,
  :subject => "7 day warning of {{review_name}} for {{subject_name}}" } )

EmailTemplate.create!( {
  :name => "Due Date Today",
  :content => %|due today

{{subject_name}}
{{initiator_name}}
{{subject_pronoun}}
{{review_url}}
{{due_date}}|,
  :enabled => true,
  :subject => "due today: {{review_name}} for {{subject_name}}" } )
