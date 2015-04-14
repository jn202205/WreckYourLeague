App.Views.SportForm = Backbone.CompositeView.extend({
  template: JST['sports/form'],
  className: 'static-homepage',

  initialize: function() {
    this.overlay = "";
  },

  events: {
    "click .clear-map": "clearMap"
  },

  render: function() {
    var content = this.template();
    this.$el.html(content);
    this.renderHeader();
    this.renderSidebar();
    this.displayMap();

    return this;
  },

  renderSidebar: function() {
    this.sports = new App.Collections.Sports();
    this.sports.fetch({
      data: {
        all_sports: true,
        current_user: false
      }
    });
    var view = new App.Views.SportsFormSidebar({
      collection: this.sports
    });

    this.addSubview('.form-container', view);
  },

  clearMap: function(event) {
    event.preventDefault();
    if (this.overlay !== "") {
      this.overlay.setMap(null);
    }
    this.overlay = "";
  },

  displayMap: function() {
    var view = new App.Views.GoogleMaps({
      model: App.currUser,
      parentView: this
    });
    this.$('.gmap-container').append(view.$el);
    view.initializeMap();
    this.addSubview('.map-container', view);
  },

  renderHeader: function() {
    var view = new App.Views.Header({
      model: this.model
    });

    this.addSubview('.dashboard-head', view);
  },

});