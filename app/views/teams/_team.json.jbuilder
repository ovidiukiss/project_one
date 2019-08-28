json.extract! team, :id, :name
json.set! :manager do
  json.set! :first_name, team.manager.first_name
  json.set! :last_name, team.manager.last_name
  json.set! :age, team.manager.age
end