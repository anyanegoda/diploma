class CreateSettings < ActiveRecord::Migration[5.2]
  def change
    create_table :settings do |t|
      t.string :discipline_full
      t.string :discipline_extramural
      t.string :training_direction_full
      t.string :training_direction_extramural
      t.string :course_full
      t.string :course_extramural
      t.string :contingent_full
      t.string :contingent_extramural
      t.string :subgroups_full
      t.string :subgroups_extramural
      t.string :semester_full
      t.string :lectures_full
      t.string :lectures_extramural
      t.string :practical_classes_full
      t.string :practical_classes_extramural
      t.string :laboratory_classes_full
      t.string :laboratory_classes_extramural
      t.string :consultation_semester_full
      t.string :consultation_semester_extramural
      t.string :consultation_exam_full
      t.string :consultation_exam_extramural
      t.string :test_full
      t.string :test_extramural
      t.string :exam_full
      t.string :exam_v_extramural
      t.string :exam_w_extramural
      t.string :work_plan_full
      t.string :work_plan_extramural
      t.string :budget_hours_full
      t.string :budget_hours_extramural
      t.string :contract_hours_full
      t.string :contract_hours_extramural

      t.timestamps
    end
  end
end
