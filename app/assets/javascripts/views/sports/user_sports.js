App.Views.UserSports = Backbone.CompositeView.extend({
  template: JST['sports/user_sports'],
  className: 'user-sports',

  initialize: function() {
    this.listenTo(this.collection, 'sync', this.render);
  },

  render: function() {
    var content = this.template();
    this.$el.html(content);

    this.addSports();
    this.attachSubviews();
    return this;
  },

  addSport: function(sport) {
    var view = new App.Views.SportListing({
      model: sport
    });

    this.addSubview('.sport-listings', view);
  },

  addSports: function() {
    this.collection.each(this.addSport.bind(this));
  }
});