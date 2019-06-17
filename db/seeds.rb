
Base.create!(base_name: "管理部",
             postcode: "2320008",
             address: "横浜市南区庚台4-10-15")
          
User.create!(name:  "管理者",
             email: "email@gmail.com",
             phone_num: "08012345678",
             password:              "password",
             password_confirmation: "password",
             admin: true,
             base_id: 1)