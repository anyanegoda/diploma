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

Setting.create(discipline_full: 'Дисциплина', discipline_extramural: 'Дисциплина', training_direction_full: 'Направление подготовки', training_direction_extramural: 'Направление подготовки',
                course_full: 'Курс', course_extramural: 'Курс', contingent_full: 'Контингент', contingent_extramural: 'Конт',
                subgroups_full: 'Количество подгрупп', subgroups_extramural: 'Кол.подгр', semester_full: 'Семестр', lectures_full: 'Лекций', lectures_extramural: 'Лекций',
                practical_classes_full: 'Практических занятий', practical_classes_extramural: 'Практических занятий ', laboratory_classes_full: 'Лабораторных занятий', laboratory_classes_extramural: 'Лабораторных занятий',
                consultation_full: 'Консультации', consultation_extramural: 'Консультации', exam_extramural: 'Экзамен', test_plan_full: 'Зачет', test_plan_extramural: 'Зачёт',
                exam_full: 'Экзамен', exam_v_extramural: 'Экзамен усн', exam_w_extramural: 'Экзамен письм', work_plan_full: 'Предусмотрено рабочим учебным планом', work_plan_extramural: 'Предусмотрено рабочим учебным планом',
                budget_hours_full: 'Расчет часов (бюджет)', budget_hours_extramural: 'Расчёт часов (бюджет)', contract_hours_full: 'Расчет часов (договор)', contract_hours_extramural: 'Расчёт часов (договор)',
                department: 'КТ', modular_control_full: 'МК', test_hours_full: 'Зачет', test_hours_extramural: 'Зачет', years: '2018 / 2019'
               )
