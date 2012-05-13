/**
 * Created with IntelliJ IDEA.
 * User: rubenmorato
 * Date: 13/05/12
 * Time: 13:38
 * To change this template use File | Settings | File Templates.
 */
package views {


import com.hexagonstar.util.debug.Debug;

import events.StreamingEvent;

import flash.display.MovieClip;
import flash.events.Event;

import com.greensock.TweenLite;
import com.greensock.TweenMax;

import flash.events.TimerEvent;

import flash.utils.Timer;

public class CronoView extends MovieClip{

        private var _this:CronoView;
        private var _crono:Crono_mc;
        private var _diaFinal:Date;
        private var cronometroCuentaRegresiva:Timer;
        private var _evento:StreamingEvent;


        public function CronoView() {
            _crono = new Crono_mc();
            _this = this;
            _this.visible = false;
            _this.alpha = 0;
            _this.addEventListener(Event.ADDED_TO_STAGE, init);

        }

        private function init(e:Event):void
        {

            _this.removeEventListener(Event.ADDED_TO_STAGE, init);
            _this.stage.addEventListener(Event.RESIZE, ajusta);
            _this.addChild(_crono);

            _this.visible = true;
            TweenMax.to(_this, 1, {alpha:1});

            ajusta();
        }

        public function startCrono(_ano:int,_dia:int,_mes:int,_hora:int,_minuto:int){

            _diaFinal = new Date(_ano,_mes-1,_dia,_hora,_minuto);
            cronometroCuentaRegresiva = new Timer(1000);
            cronometroCuentaRegresiva.addEventListener(TimerEvent.TIMER, actualizarHora);
            cronometroCuentaRegresiva.start();
        }

        private function actualizarHora(e:TimerEvent):void
        {
            var hoy:Date = new Date();
            var tiempoRestante:Number = _diaFinal.getTime() - hoy.getTime();
            var segundos:Number = Math.floor(tiempoRestante / 1000);
            var minutos:Number = Math.floor(segundos / 60);
            var horas:Number = Math.floor(minutos / 60);
            var dias:Number = Math.floor(horas / 24);

            segundos %= 60;
            minutos %= 60;
            horas %= 24;

            var sec:String = segundos.toString();
            var min:String = minutos.toString();
            var hrs:String = horas.toString();
            var d:String = dias.toString();

            if(dias > 0){
                if(dias > 1){
                    d = String(dias) + ' dias, ';
                } else {
                    d = String(dias) + ' dia, ';
                }
            } else {
                d = '';
            }
            if(horas > 0){
                if(horas > 1){
                    hrs = String(horas) + ' horas ';
                } else {
                    hrs = String(horas) + ' hora ';
                }
            } else {
                hrs = '';
            }
            if(minutos > 0){
                if(minutos > 1){
                    min = String(minutos) +","+sec+' minutos ';
                } else {
                    min = String(minutos) +","+sec+' minuto ';
                }
                if(hrs != ''){
                    min = 'y '+min;
                }
            } else {
                min = '';
            }

            if(d == '' && hrs == '' && min == ''){
                cronometroCuentaRegresiva.removeEventListener(TimerEvent.TIMER, actualizarHora);
                _crono.texto_mc.texto_txt.text = 'Estableciendo conexión, espere por favor.';
                TweenMax.to(_this, 1, {alpha:1, delay:1, onComplete:function(){
                    _evento = new StreamingEvent(StreamingEvent.INIT_VIDEO);
                    _this.dispatchEvent(_evento);
                    _this.visible = false;
                }});
            } else {
                var tiempo:String = 'Faltan '+d+hrs+min;
                _crono.texto_mc.texto_txt.text = tiempo;
            }
        }

        private function ajusta(e:Event = null){
            _this.x = stage.stageWidth/2;
            _this.y = stage.stageHeight/2;

            var stageAspectRatio = stage.stageWidth / stage.stageHeight;

            var imageAspectRatio = _crono.fondo_mc.width / _crono.fondo_mc.height;

            if (stageAspectRatio >= imageAspectRatio)
            {
                _crono.fondo_mc.width = stage.stageWidth;
                _crono.fondo_mc.height = stage.stageWidth / imageAspectRatio;
            }
            else
            {
                _crono.fondo_mc.height = stage.stageHeight;
                _crono.fondo_mc.width = stage.stageHeight * imageAspectRatio;
            }
        }


    }
}
