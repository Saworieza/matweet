4.times do |n|
	name = "User-#{n+1}"
	username = "User-#{n+1}"
	email = "example-#{n+1}@gmail.com"
	about = " #Chairman #CEO #BoardMember #BizConsultant #LeadershipCoach #Forbes #HBR #Author-The 7 Non-Negotiables of Winning https://tinyurl.com/y9yf86uq  @CamFoundationFB "
	password = "password"
	User.create!(
		name: name,
		username: username,
		email: email,
		about: about,
		password: password,
		password_confirmation: password)
end