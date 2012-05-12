package {
import contexts.MainContext;

import flash.display.MovieClip;
import flash.display.StageAlign;
import flash.display.StageScaleMode;
import flash.system.Security;

import org.robotlegs.core.IContext;

[SWF(frameRate="25", height="600", width="1000", backgroundColor="#333333")]

public class Flex_Contador extends MovieClip {

    private var contexto:IContext;

    public function Flex_Contador() {

        Security.loadPolicyFile('http://api.facebook.com/crossdomain.xml');
        Security.loadPolicyFile('http://profile.ak.fbcdn.net/crossdomain.xml');
        Security.allowDomain('http://profile.ak.fbcdn.net');
        Security.allowInsecureDomain('http://profile.ak.fbcdn.net');

        /*this.stage.align = StageAlign.TOP_LEFT;
        this.stage.scaleMode = StageScaleMode.NO_SCALE; */

        contexto = new MainContext(this);

        // TODO crear la precarga

    }
}
}
