import Ember from 'ember';

export default Ember.Route.extend({
  model:function(){
    return Ember.RSVP.hash({lecturers:this.store.findAll('lecturer'),coursetypes:this.store.findAll('coursetype'),faculties:this.store.findAll('faculty'),semesters:this.store.findAll('semester')});
  }
});
