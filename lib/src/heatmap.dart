import 'package:flutter/material.dart';
import 'package:heatmap_calendar_flutter/src/data/heatmap_datasets.dart';
import '../heatmap_calendar_flutter.dart';
import './widgets/heatmap_page.dart';
import './widgets/heatmap_color_tip.dart';
import './enums/heatmap_color_mode.dart';
import './utils/date_util.dart';

class Myapp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
    );
  }
}


class HeatMap extends StatefulWidget {

  /// HeatMap shows the start day of [startDate]'s week.
  ///
  /// Default value is 1 year before of the [endDate].
  /// And if [endDate] is null, then set 1 year before of the [DateTime.now].
  final DateTime? startDate;

  /// Default value is [DateTime.now].
  final DateTime? endDate;

  final Map<DateTime, HeatmapData>? datasets;

  final Color? defaultColor;

  final Color? textColor;

  final double? size;

  final double? fontSize;

  /// Be aware that first Color is the maximum value if [ColorMode] is [ColorMode.opacity].
  final Map<int, Color> colorsets;

  /// ColorMode changes the color mode of blocks.
  ///
  /// [ColorMode.opacity] requires just one colorsets value and changes color
  /// dynamically based on hightest value of [datasets].
  /// [ColorMode.color] changes colors based on [colorsets] thresholds key value.
  ///
  /// Default value is [ColorMode.opacity].
  final ColorMode colorMode;

  /// HeatmapCalendarType changes the UI mode of blocks.
  ///
  /// [HeatmapCalendarType.intensity] 
  /// d[datasets].
  /// [HeatmapCalendarType.widgets] 
  ///
  /// [HeatmapCalendarType.intensity].
  final HeatmapCalendarType heatmapType;

  /// [HeatmapCalendarType] is [HeatmapCalendarType.widgets]
  final List<HeatmapChildrenData>? heatmapWidgetLegends;

  final Function(DateTime, HeatmapData)? onClick;

  final EdgeInsets? margin;

  final double? borderRadius;


  final bool? showText;


  final bool? showColorTip;

  final bool scrollable;

  /// 
  ///
  /// 
  /// [colorTipHelper.length]
  /// [Text].
  final List<Widget?>? colorTipHelper;

  /// [HeatMapColorTip]
  final int? colorTipCount;

  ///[HeatMapColorTip]
  final double? colorTipSize;

  const HeatMap({
    Key? key,
    required this.colorsets,
    this.colorMode = ColorMode.opacity,
    this.heatmapType = HeatmapCalendarType.intensity,
    this.heatmapWidgetLegends,
    this.startDate,
    this.endDate,
    this.textColor,
    this.size = 20,
    this.fontSize,
    this.onClick,
    this.margin,
    this.borderRadius,
    this.datasets,
    this.defaultColor,
    this.showText = false,
    this.showColorTip = true,
    this.scrollable = false,
    this.colorTipHelper,
    this.colorTipCount,
    this.colorTipSize,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _HeatMap();
}

class _HeatMap extends State<HeatMap> {
  /// [SingleChildScrollView]
  Widget _scrollableHeatMap(Widget child) {
    return widget.scrollable
        ? SingleChildScrollView(
            reverse: true,
            scrollDirection: Axis.horizontal,
            child: child,
          )
        : child;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        _scrollableHeatMap(HeatMapPage(
          endDate: widget.endDate ?? DateTime.now(),
          startDate: widget.startDate ??
              DateUtil.oneYearBefore(widget.endDate ?? DateTime.now()),
          colorMode: widget.colorMode,
          heatmapType: widget.heatmapType,
          size: widget.size,
          fontSize: widget.fontSize,
          datasets: widget.datasets,
          defaultColor: widget.defaultColor,
          textColor: widget.textColor,
          colorsets: widget.colorsets,
          borderRadius: widget.borderRadius,
          onClick: widget.onClick,
          margin: widget.margin,
          showText: widget.showText,
        )),

        if (widget.showColorTip == true)
          HeatMapColorTip(
            colorMode: widget.colorMode,
            heatmapType: widget.heatmapType,
            heatmapWidgetLegends: widget.heatmapWidgetLegends,
            colorsets: widget.colorsets,
            leftWidget: widget.colorTipHelper?[0],
            rightWidget: widget.colorTipHelper?[1],
            containerCount: widget.colorTipCount,
            size: widget.colorTipSize,
          ),
      ],
    );
  }
}
