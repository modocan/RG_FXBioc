/**
 * Created with IntelliJ IDEA.
 * User: barbaradominguez
 * Date: 22/04/12
 * Time: 14:14
 * To change this template use File | Settings | File Templates.
 */
package models {
public interface IPreguntasModel {

    function enviaPregunta(usuario:Object, pregunta:String):void

    function damePreguntas():void

}
}
