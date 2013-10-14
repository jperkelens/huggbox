use strict;

package Plugins::huggbox;

our %functions = ();
sub initPlugin {
    %functions = (
        'up' => sub {
            my $client = shift;
            $client->bumpUp();
        },
        'down' => sub {
            my $client = shift;
            $client->bumpDown();
        },
        'left' => sub {
            my $client = shift;
            Slim::Buttons::Common::popModeRight($client);
        },
        'right' => sub {
            my $client = shift;
            $client->bumpRight();
        },
        'play' => sub {
            my $client = shift;
            my @pargs = 'rescan';
            my $line1 = $client->string('PLUGIN_RESCAN_MUSIC_LIBRARY');
            my $line2 = $client->string('PLUGIN_RESCAN_RESCANNING');
            $client->showBriefly(, $line1, $line2);
        }
    );
}

sub webPages {
    Slim::Web::HTTP::addPageFunction("plugins/huggbox/enable.html",  \&handleEnable);
    Slim::Web::Pages->addPageLinks('plugins', {"plugins/huggbox/index.htm", \&handleIndex} );
}

sub lines {
    my $client = shift;
    my $line1 = $client->string('PLUGIN_RESCAN_MUSIC_LIBRARY');
    my $line2 = $client->string('PLUGIN_RESCAN_PRESS_PLAY');
    return ($line1, $line2);
}

sub setMode { my $client = shift; $client->lines(\&lines); }
sub getFunctions { return \%functions; }
sub getDisplayName { return "Huggbox"; }

initPlugin();
1;
