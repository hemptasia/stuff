blanks = User.all.select do |user|
  user.first_name.blank?
end

puts "Updating #{blanks.count} users."

blanks.each do |user|
  email_parts = user.email.split("@")

  email_name = email_parts.first.split(".")

  if email_name.count > 1
    first_name = email_name[0].titlecase
    last_name = email_name[1].titlecase
  else
    first_name = email_parts.first
    last_name = email_parts.last
  end

  user.first_name = first_name
  user.last_name = last_name

  begin user.save!
    print "."
  rescue => e
    print %Q[Unable to save "#{first_name} #{last_name}", id ##{user.id}: #{user.errors.full_messages.join(", ")}]
  end
end
