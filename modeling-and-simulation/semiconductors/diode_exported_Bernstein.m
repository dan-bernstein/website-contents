classdef diode_exported_Bernstein < matlab.apps.AppBase

    % Properties that correspond to app components
    properties (Access = public)
        UIFigure                matlab.ui.Figure
        UIAxes                  matlab.ui.control.UIAxes
        SaturationCurrentLabel  matlab.ui.control.Label
        SliderSat               matlab.ui.control.Slider
        DiodeIdealityLabel      matlab.ui.control.Label
        SliderTemp              matlab.ui.control.Slider
    end

    % Callbacks that handle component events
    methods (Access = private)

        % Callback function: SliderSat, SliderSat, SliderTemp, 
        % SliderTemp
        function StartValueChanged(app, event)
%           value = app.Start.Value;
           
            
            ideal=app.SliderTemp.Value;
            sat=app.SliderSat.Value;
       
            
            volt=[-1:0.01:0.2];
            temp=300;
            Vtherm=temp/11586;
            vZ=-0.5;
            
            for i=1:length(volt)
                if volt(i)>vZ
                    curr(i)=sat*(exp((volt(i)/(ideal*Vtherm)))-1);
                    expone=exp(volt/(ideal*Vtherm));
                    expone=expone-1;
                    curr=sat*expone;
                else
                    volt(i)=vZ;
                    curr(i)=-1;
                end
            end
           
            
            currfirst=-max(curr)*0.9;
            
            curr=[currfirst,curr];
            volt=[vZ,volt];
            
            a=min(curr)*1.05;
            b=max(curr)*1.05;
            xAxisY=[a,b];
            xAxisX=[0,0];
            
            c=min(volt)*1.05;
            d=max(volt)*1.05;
            yAxisX=[c,d];
            yAxisY=[0,0];
            
            
            plot(app.UIAxes,volt,curr,xAxisX,xAxisY,'black',yAxisX,yAxisY,'black')
            
            
        end
    end

    % Component initialization
    methods (Access = private)

        % Create UIFigure and components
        function createComponents(app)

            % Create UIFigure and hide until all components are created
            app.UIFigure = uifigure('Visible', 'off');
            app.UIFigure.Position = [100 100 722 523];
            app.UIFigure.Name = 'UI Figure';

            % Create UIAxes
            app.UIAxes = uiaxes(app.UIFigure);
            title(app.UIAxes, 'I-V Curve for an Ideal Diode')
            xlabel(app.UIAxes, 'Voltage (V)')
            ylabel(app.UIAxes, 'Current (A)')
            app.UIAxes.PlotBoxAspectRatio = [1.6712962962963 1 1];
            app.UIAxes.GridLineStyle = '--';
            app.UIAxes.XMinorTick = 'on';
            app.UIAxes.YMinorTick = 'on';
            app.UIAxes.XGrid = 'on';
            app.UIAxes.YGrid = 'on';
            app.UIAxes.Position = [33 105 592 419];

            % Create SaturationCurrentLabel
            app.SaturationCurrentLabel = uilabel(app.UIFigure);
            app.SaturationCurrentLabel.HorizontalAlignment = 'right';
            app.SaturationCurrentLabel.Position = [21 42 104 22];
            app.SaturationCurrentLabel.Text = 'Saturation Current (A)';

            % Create SliderSat
            app.SliderSat = uislider(app.UIFigure);
            app.SliderSat.Limits = [1e-14 1e-08];
            app.SliderSat.ValueChangedFcn = createCallbackFcn(app, @StartValueChanged, true);
            app.SliderSat.ValueChangingFcn = createCallbackFcn(app, @StartValueChanged, true);
            app.SliderSat.Position = [146 51 150 3];
            app.SliderSat.Value = 5e-09;

            % Create DiodeIdealityLabel
            app.DiodeIdealityLabel = uilabel(app.UIFigure);
            app.DiodeIdealityLabel.HorizontalAlignment = 'right';
            app.DiodeIdealityLabel.Position = [369 42 79 22];
            app.DiodeIdealityLabel.Text = 'Diode Ideality';

            % Create SliderTemp
            app.SliderTemp = uislider(app.UIFigure);
            app.SliderTemp.Limits = [1 2];
            app.SliderTemp.ValueChangedFcn = createCallbackFcn(app, @StartValueChanged, true);
            app.SliderTemp.ValueChangingFcn = createCallbackFcn(app, @StartValueChanged, true);
            app.SliderTemp.Position = [469 51 150 3];
            app.SliderTemp.Value = 1.5;

            % Show the figure after all components are created
            app.UIFigure.Visible = 'on';
        end
    end

    % App creation and deletion
    methods (Access = public)

        % Construct app
        function app = diode_exported_Bernstein

            % Create UIFigure and components
            createComponents(app)

            % Register the app with App Designer
            registerApp(app, app.UIFigure)

            if nargout == 0
                clear app
            end
        end

        % Code that executes before app deletion
        function delete(app)

            % Delete UIFigure when app is deleted
            delete(app.UIFigure)
        end
    end
end