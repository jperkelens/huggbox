package Plugins::Huggbox::Settings;

# SqueezeCenter Copyright 2001-2007 Logitech.
# This program is free software; you can redistribute it and/or
# modify it under the terms of the GNU General Public License,
# version 2.

# Settings file.
# This file contains stuff generally applicable to the web interface used to set the settings for the plugin

# All good/required uses to have in here.
use strict;
use base qw(Slim::Web::Settings);
use Slim::Utils::Prefs;
use Slim::Utils::Log;

# Used for logging.
my $log = Slim::Utils::Log->addLogCategory({
	'category'     => 'plugin.helloworld',
	'defaultLevel' => 'INFO',
#	'defaultLevel' => 'DEBUG',
	'description'  => 'Huggbox Settings',
});



# my own debug outputer
sub myDebug {
	my $msg = shift;

	$log->info("*** Huggbox - Settings *** $msg");
}

# This gets the current preferences stored for the plugin.
my $prefs = preferences('plugin.huggbox');

# See strings.txt to see what PLUGIN_HELLOWORLD is expanded into.
sub name {
	return Slim::Web::HTTP::protectName('PLUGIN_HUGGBOX');
}

sub page {
	return Slim::Web::HTTP::protectURI('plugins/Huggbox/settings/basic.html');
}

# Required function used to process the web page input.
# This handler is called whenever the webpage is displayed as well as when a setting is "applied."
sub handler {
	my ($class, $client, $params) = @_;

	myDebug("in handler");

	# When "apply" is pressed on the settings page, this function gets called.
	# So, double check that the apply button was pressed and if so check that the field was populated.
	# If so, set that value into the prefs variable
	if ($params->{'saveSettings'} && $params->{'helloname'}) {
		my $helloname = $params->{'helloname'};
		$prefs->set('helloname', " $helloname"); # add a leading space to make the message display nicely
	}

	# This puts the value on the webpage.
	$params->{'prefs'}->{'helloname'} = $prefs->get('helloname');

	return $class->SUPER::handler($client, $params);
}

1;

__END__
