/**
 * Created by IntelliJ IDEA.
 * User: gonzalocedillo
 * Date: 03/05/12
 * Time: 20:12
 * To change this template use File | Settings | File Templates.
 */
package commands {
import assets.rub.clases.CajaPin;

import org.robotlegs.mvcs.Command;

import views.CajaPinView;

public class CreaPinCommand extends Command {
    public function CreaPinCommand() {
    }

    override public function execute():void
    {
        var cajapin:CajaPinView = new CajaPinView();
        cajapin.name = 'caja_pin';
        contextView.addChild(cajapin);
    }

}
}
