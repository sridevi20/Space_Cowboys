require('pry-byebug')
require_relative('models/Bounty.rb')

hunter1 = BountyTrack.new({'name' => 'Cad Bane',
                      'species' => 'Duros',
                       'bounty' => '100',
                       'danger_level' => 'medium'
                       })
                       hunter1.save()

 hunter2 = BountyTrack.new({'name' => 'Boba Fett',
                             'species' => 'Humans',
                              'bounty' => '50',
                              'danger_level' => 'low'
                              })
                             hunter2.save()

  hunter = BountyTrack.all()

  # hunter = BountyTrack.delete_all()

  hunter1.name =  'Zam_Wesell'

   hunter1.update()
