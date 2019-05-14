# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
# User.create(email: 'negoda.anya@gmail.com',password: 'password', admin: true)
User.create(name: 'admin', email: "negoda.anya@gmail.com", password: "password", password_confirmation: "password", admin: true)

NameWork.create([{ name: 'Учебно-методическая работа'},
             { name: 'Организационно-методическая работа'},
             {name: 'Научно-исследовательская работа'},
             {name: 'Воспитательная работа'}])


Work.create([{ work_title: 'Подготовка к лекции (если учебная дисциплина преподается впервые)', time_rate: 2, note: 'на 1 час занятий', name_work_id: 1 },
             { work_title: 'Подготовка к практическим (семинарским, лабораторным) занятиям (если учебная дисциплина преподается впервые)', time_rate: 1, note: 'на 1 час занятий', name_work_id: 1 }])
