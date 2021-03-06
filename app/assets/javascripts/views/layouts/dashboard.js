App.Views.Dashboard = Backbone.CompositeView.extend({
  template: JST['dashboard/dashboard'],
  className: 'static-homepage',

  initialize: function() {
    this.listenTo(this.model, 'sync', this.render);
  },

  events: {
    'click .add-sport': 'addEditSports',
    'click .add-game': 'playerSearch'
  },

  addEditSports: function(event) {
    event.preventDefault();
    Backbone.history.navigate('/sports_form', {
      trigger: true
    });
  },

  playerSearch: function(event) {
    event.preventDefault();
    Backbone.history.navigate('/player_search', {
      trigger: true
    });
  },

  render: function() {
    var content = this.template();
    this.$el.html(content);
    this.renderHeader();
    this.renderUserGames();
    this.renderUserSports();
    this.renderAreaPlayers();
    // this.renderSidebar();
    return this;
  },

  renderAreaPlayers: function() {
    this.players = new App.Collections.Players();
    this.players.fetch({
      data: {
        limit: 3
      }
    });
    var view = new App.Views.AreaPlayers({
      collection: this.players,
    });

    this.addSubview('.sections', view);
  },

  renderHeader: function() {
    var view = new App.Views.Header({
      model: this.model
    });

    this.addSubview('.dashboard-head', view);
  },

  renderUserGames: function() {
    var games = new App.Collections.Games();
    games.fetch();
    var view = new App.Views.UserGames({
      collection: games
    });

    this.addSubview('.your-games', view);
  },

  renderUserSports: function() {
    var view = new App.Views.UserSports({
      collection: App.currUser.sports()
    });

    this.addSubview('.your-sports', view);
  },

  renderSidebar: function() {
    this.sports = new App.Collections.Sports();
    this.sports.fetch({
      data: {
        limit: 6
      }
    });
    var view = new App.Views.Sidebar({
      collection: this.sports
    });

    this.addSubview('.sidebar', view);
  }
});
